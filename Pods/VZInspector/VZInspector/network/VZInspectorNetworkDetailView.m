//
//  VZInspectorNetworkDetailView.m
//  VZInspector
//
//  Created by moxin on 15/4/15.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "VZInspectorNetworkDetailView.h"
#import "VZInspectorUtility.h"
#import "VZNetworkTransaction.h"
#import "VZNetworkRecorder.h"
#import <objc/runtime.h>

@interface UITableViewCell(Index)

@property(nonatomic,strong) NSIndexPath* indexPath;

@end

@implementation UITableViewCell(Index)

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    objc_setAssociatedObject(self, "VZInsepctorNetworkDetailViewCell", indexPath, OBJC_ASSOCIATION_RETAIN);
}

- (NSIndexPath* )indexPath
{
    return objc_getAssociatedObject(self, "VZInsepctorNetworkDetailViewCell");
}

@end

@interface VZInspectorNetworkDetailSection : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *rows;

@end

@implementation VZInspectorNetworkDetailSection

@end

@interface VZInspectorNetworkDetailRow : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detailText;
@property (nonatomic, assign) NSUInteger type; //1 => POST BODY, 2 => HTTP RESPONSE, 3 => REQUEST URL, 4 => REQUEST PARAMS
@property (nonatomic,assign) NSString* requestURLString;
@property (nonatomic,strong) NSString* responseString;
@property (nonatomic,strong) NSString* postBodyString;
@property (nonatomic,strong) NSString* requestParamsString;

@end

@implementation VZInspectorNetworkDetailRow

@end

@interface VZInspectorNetworkDetailView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIButton* backBtn;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UILabel* textLabel;
@property(nonatomic,copy) NSArray *sections;

@end

@implementation VZInspectorNetworkDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
      
        self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 44, 44)];
        self.backBtn.backgroundColor = [UIColor clearColor];
        [self.backBtn setTitle:@"<-" forState:UIControlStateNormal];
        [self.backBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.backBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.backBtn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop
        [self addSubview:self.backBtn];
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,44, frame.size.width, frame.size.height-44)];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate   = self;
        self.tableView.dataSource = self;
        self.tableView.tableHeaderView = nil;
        
        self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, frame.size.width-80, 44)];
        self.textLabel.text = @"Details";
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont systemFontOfSize:18.0f];
        [self addSubview:self.textLabel];
        
        [self addSubview:self.tableView];
        
    }
    return self;
}

- (void)setTransaction:(VZNetworkTransaction *)transaction
{
    if (_transaction != transaction) {
        _transaction = transaction;

        self.textLabel.text = transaction.response.MIMEType;
        [self rebuildTableSections];
    }
}
- (void)setSections:(NSArray *)sections
{
    if (![_sections isEqual:sections]) {
        _sections = [sections copy];
        [self.tableView reloadData];
    }
}

- (VZInspectorNetworkDetailRow* )rowAtIndexPath:(NSIndexPath* )indexPath
{
    VZInspectorNetworkDetailSection *sectionModel = [self.sections objectAtIndex:indexPath.section];
    return [sectionModel.rows objectAtIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    VZInspectorNetworkDetailSection *sections = [self.sections objectAtIndex:section];
    return [sections.rows count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* header = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    header.backgroundColor = [UIColor orangeColor];
    header.textColor = [UIColor whiteColor];
    header.font = [UIFont boldSystemFontOfSize:14.0f];
    header.alpha = 0.6;
    
    VZInspectorNetworkDetailSection *sectionModel = [self.sections objectAtIndex:section];
    NSString* text = [@"   " stringByAppendingString:sectionModel.title];
    header.text = text;
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* network_detail_identifier = @"network_detail_identifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:network_detail_identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:network_detail_identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.detailTextLabel.textColor = [UIColor orangeColor];
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onSelfClicked:)]];
    }
    
    VZInspectorNetworkDetailRow* row = [self rowAtIndexPath:indexPath];
    
    if (row.type > 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    

    cell.textLabel.text = row.title;
    cell.detailTextLabel.text = row.detailText;
    
    cell.indexPath = indexPath;
    cell.tag = row.type;
    [cell.textLabel sizeToFit];
    [cell.detailTextLabel sizeToFit];
    
    return cell;
}

- (void)onSelfClicked:(UITapGestureRecognizer* )sender
{
    [[self viewWithTag:998]removeFromSuperview];
    
    UITableViewCell* cell = (UITableViewCell* )sender.view;
    
    NSInteger type = cell.tag;
    NSIndexPath* indexPath = cell.indexPath;
    
    NSString* stringForDisplay = @"";
    VZInspectorNetworkDetailRow* row = [self rowAtIndexPath:indexPath];
    
    if (type == 1) {
        
        //Post Body
        stringForDisplay = row.postBodyString;
    }
    else if(type == 2)
    {
        //Response
        stringForDisplay = row.responseString;
    }
    else if(type == 3)
    {
        stringForDisplay = row.requestURLString;
    }
    else if (type == 4)
    {
        stringForDisplay = row.requestParamsString;
    }
    else
        return;
    
    UITextView* textView = [[UITextView alloc]initWithFrame:CGRectInset(self.bounds, 30, 30)];
    textView.tag = 998;
    [textView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTextViewClosed:)]];
    textView.text = stringForDisplay;
    [self addSubview:textView];
}

- (void)onTextViewClosed:(UITapGestureRecognizer* )sender
{
    [sender.view removeFromSuperview];
}

- (void)rebuildTableSections
{
    NSMutableArray *sections = [NSMutableArray array];
    
    VZInspectorNetworkDetailSection
    *generalSection = [[self class] generalSectionForTransaction:self.transaction];
    if ([generalSection.rows count] > 0) {
        [sections addObject:generalSection];
    }
    VZInspectorNetworkDetailSection *requestHeadersSection = [[self class] requestHeadersSectionForTransaction:self.transaction];
    if ([requestHeadersSection.rows count] > 0) {
        [sections addObject:requestHeadersSection];
    }
    VZInspectorNetworkDetailSection *queryParametersSection = [[self class] queryParametersSectionForTransaction:self.transaction];
    if ([queryParametersSection.rows count] > 0) {
        [sections addObject:queryParametersSection];
    }
    VZInspectorNetworkDetailSection *postBodySection = [[self class] postBodySectionForTransaction:self.transaction];
    if ([postBodySection.rows count] > 0) {
        [sections addObject:postBodySection];
    }
    VZInspectorNetworkDetailSection *responseHeadersSection = [[self class] responseHeadersSectionForTransaction:self.transaction];
    if ([responseHeadersSection.rows count] > 0) {
        [sections addObject:responseHeadersSection];
    }
    
    self.sections = sections;
}

- (void)onBack
{
    [self.delegate onDetailBack];
}

+ (VZInspectorNetworkDetailSection *)generalSectionForTransaction:(VZNetworkTransaction *)transaction
{
    NSMutableArray *rows = [NSMutableArray array];
    
    VZInspectorNetworkDetailRow *requestURLRow = [[VZInspectorNetworkDetailRow alloc] init];
    requestURLRow.title = @"Request URL";
    NSURL *url = transaction.request.URL;
    requestURLRow.detailText = url.absoluteString;
    requestURLRow.type = 3;
    requestURLRow.requestURLString = url.absoluteString;

    [rows addObject:requestURLRow];
    
    VZInspectorNetworkDetailRow *requestMethodRow = [[VZInspectorNetworkDetailRow alloc] init];
    requestMethodRow.title = @"Request Method";
    requestMethodRow.detailText = transaction.request.HTTPMethod;
    [rows addObject:requestMethodRow];
    
    if ([transaction.request.HTTPBody length] > 0)
    {
        VZInspectorNetworkDetailRow *postBodySizeRow = [[VZInspectorNetworkDetailRow alloc] init];
        postBodySizeRow.title = @"Request Body Size";
        postBodySizeRow.detailText = [NSByteCountFormatter stringFromByteCount:[transaction.request.HTTPBody length] countStyle:NSByteCountFormatterCountStyleBinary];
        [rows addObject:postBodySizeRow];
        
        VZInspectorNetworkDetailRow *postBodyRow = [[VZInspectorNetworkDetailRow alloc] init];
        postBodyRow.title = @"Request Body";
        postBodyRow.detailText = @"tap to view";
        postBodyRow.type = 1;
        
       // NSString *contentType = [transaction.request valueForHTTPHeaderField:@"Content-Type"];
        NSData* data = [self postBodyDataForTransaction:transaction];
        NSString *prettyJSON = [VZInspectorUtility prettyJSONStringFromData:data];
        postBodyRow.postBodyString = prettyJSON;

        [rows addObject:postBodyRow];
    }
    
    NSString *statusCodeString = [VZInspectorUtility statusCodeStringFromURLResponse:transaction.response];
    if ([statusCodeString length] > 0) {
        VZInspectorNetworkDetailRow *statusCodeRow = [[VZInspectorNetworkDetailRow alloc] init];
        statusCodeRow.title = @"Status Code";
        statusCodeRow.detailText = statusCodeString;
        [rows addObject:statusCodeRow];
    }
    
    if (transaction.error) {
        VZInspectorNetworkDetailRow *errorRow = [[VZInspectorNetworkDetailRow alloc] init];
        errorRow.title = @"Error";
        errorRow.detailText = transaction.error.localizedDescription;
        [rows addObject:errorRow];
    }
    
    VZInspectorNetworkDetailRow *responseBodyRow = [[VZInspectorNetworkDetailRow alloc] init];
    responseBodyRow.title = @"Response Body";
    responseBodyRow.type = 2;
    NSData *responseData = [[VZNetworkRecorder defaultRecorder] cachedResponseBodyForTransaction:transaction];
    
    if ([responseData length] > 0)
    {
        responseBodyRow.detailText = @"tap to view";
        NSString *prettyJSON = [VZInspectorUtility prettyJSONStringFromData:responseData];
        responseBodyRow.responseString = prettyJSON;
    }
    else
    {
        BOOL emptyResponse = transaction.receivedDataLength == 0;
        responseBodyRow.detailText = emptyResponse ? @"empty" : @"not in cache";
    }
    [rows addObject:responseBodyRow];
    
    VZInspectorNetworkDetailRow *responseSizeRow = [[VZInspectorNetworkDetailRow alloc] init];
    responseSizeRow.title = @"Response Size";
    responseSizeRow.detailText = [NSByteCountFormatter stringFromByteCount:transaction.receivedDataLength countStyle:NSByteCountFormatterCountStyleBinary];
    [rows addObject:responseSizeRow];
    
    VZInspectorNetworkDetailRow *mimeTypeRow = [[VZInspectorNetworkDetailRow alloc] init];
    mimeTypeRow.title = @"MIME Type";
    mimeTypeRow.detailText = transaction.response.MIMEType;
    [rows addObject:mimeTypeRow];
    
    VZInspectorNetworkDetailRow *mechanismRow = [[VZInspectorNetworkDetailRow alloc] init];
    mechanismRow.title = @"Mechanism";
    mechanismRow.detailText = transaction.requestMechanism;
    [rows addObject:mechanismRow];
    
    NSDateFormatter *startTimeFormatter = [[NSDateFormatter alloc] init];
    startTimeFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    
    VZInspectorNetworkDetailRow *localStartTimeRow = [[VZInspectorNetworkDetailRow alloc] init];
    localStartTimeRow.title = [NSString stringWithFormat:@"Start Time (%@)", [[NSTimeZone localTimeZone] abbreviationForDate:transaction.startTime]];
    localStartTimeRow.detailText = [startTimeFormatter stringFromDate:transaction.startTime];
    [rows addObject:localStartTimeRow];
    
    VZInspectorNetworkDetailRow *durationRow = [[VZInspectorNetworkDetailRow alloc] init];
    durationRow.title = @"Total Duration";
    durationRow.detailText = [VZInspectorUtility stringFromRequestDuration:transaction.duration];
    [rows addObject:durationRow];
    
    VZInspectorNetworkDetailRow *latencyRow = [[VZInspectorNetworkDetailRow alloc] init];
    latencyRow.title = @"Latency";
    latencyRow.detailText = [VZInspectorUtility stringFromRequestDuration:transaction.latency];
    [rows addObject:latencyRow];
    
    VZInspectorNetworkDetailSection *generalSection = [[VZInspectorNetworkDetailSection alloc] init];
    generalSection.title = @"General";
    generalSection.rows = rows;
    
    return generalSection;
}

+ (VZInspectorNetworkDetailSection *)requestHeadersSectionForTransaction:(VZNetworkTransaction *)transaction
{
    VZInspectorNetworkDetailSection *requestHeadersSection = [[VZInspectorNetworkDetailSection alloc] init];
    requestHeadersSection.title = @"Request Headers";
    requestHeadersSection.rows = [self networkDetailRowsFromDictionary:transaction.request.allHTTPHeaderFields];
    
    return requestHeadersSection;
}

+ (VZInspectorNetworkDetailSection *)postBodySectionForTransaction:(VZNetworkTransaction *)transaction
{
    VZInspectorNetworkDetailSection *postBodySection = [[VZInspectorNetworkDetailSection alloc] init];
    postBodySection.title = @"Request Body Parameters";
    if ([transaction.request.HTTPBody length] > 0) {
        NSString *contentType = [transaction.request valueForHTTPHeaderField:@"Content-Type"];
        if ([contentType hasPrefix:@"application/x-www-form-urlencoded"]) {
            NSString *bodyString = [[NSString alloc] initWithData:[self postBodyDataForTransaction:transaction] encoding:NSUTF8StringEncoding];
            postBodySection.rows = [self networkDetailRowsFromDictionary:[VZInspectorUtility dictionaryFromQuery:bodyString]];
        }
    }
    return postBodySection;
}

+ (VZInspectorNetworkDetailSection *)queryParametersSectionForTransaction:(VZNetworkTransaction *)transaction
{
    NSDictionary *queryDictionary = [VZInspectorUtility dictionaryFromQuery:transaction.request.URL.query];
    VZInspectorNetworkDetailSection *querySection = [[VZInspectorNetworkDetailSection alloc] init];
    querySection.title = @"Query Parameters";
    querySection.rows = [self networkDetailRowsFromDictionary:queryDictionary];
    
    for(VZInspectorNetworkDetailRow* detailRow in querySection.rows)
    {
        detailRow.type = 4;
        detailRow.requestParamsString = detailRow.detailText;
    }
    
    return querySection;
}

+ (VZInspectorNetworkDetailSection *)responseHeadersSectionForTransaction:(VZNetworkTransaction *)transaction
{
    VZInspectorNetworkDetailSection *responseHeadersSection = [[VZInspectorNetworkDetailSection alloc] init];
    responseHeadersSection.title = @"Response Headers";
    if ([transaction.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)transaction.response;
        responseHeadersSection.rows = [self networkDetailRowsFromDictionary:httpResponse.allHeaderFields];
    }
    return responseHeadersSection;
}

+ (NSArray *)networkDetailRowsFromDictionary:(NSDictionary *)dictionary
{
    NSMutableArray *rows = [NSMutableArray arrayWithCapacity:[dictionary count]];
    NSArray *sortedKeys = [[dictionary allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    for (NSString *key in sortedKeys) {
        NSString *value = [dictionary objectForKey:key];
        VZInspectorNetworkDetailRow *row = [[VZInspectorNetworkDetailRow alloc] init];
        row.title = key;
        row.detailText = [value description];
        [rows addObject:row];
    }
    return [rows copy];
}

+ (NSData *)postBodyDataForTransaction:(VZNetworkTransaction *)transaction
{
    NSData *bodyData = transaction.request.HTTPBody;
    if ([bodyData length] > 0) {
        NSString *contentEncoding = [transaction.request valueForHTTPHeaderField:@"Content-Encoding"];
        if ([contentEncoding rangeOfString:@"deflate" options:NSCaseInsensitiveSearch].length > 0 || [contentEncoding rangeOfString:@"gzip" options:NSCaseInsensitiveSearch].length > 0) {
            bodyData = [VZInspectorUtility inflatedDataFromCompressedData:bodyData];
        }
    }
    return bodyData;
}


@end
