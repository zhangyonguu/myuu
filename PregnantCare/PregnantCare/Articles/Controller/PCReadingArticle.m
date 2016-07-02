//
//  PCReadingArticle.m
//  PregnantCare
//
//  Created by tarena on 16/6/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PCReadingArticle.h"
#import "NSAttributedString+YYText.h"

#import "SDWebImageDownloader.h"


@interface PCReadingArticle ()
@property (weak, nonatomic) IBOutlet UITextView *articleTextView;
@property (nonatomic, strong) PCArticle *article;

@end

@implementation PCReadingArticle

-(instancetype)initWithArticle:(PCArticle *)article
{
    if (self = [super init]) {
        _article = article;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.articleTextView.editable = NO;
    self.articleTextView.showsVerticalScrollIndicator = NO;
    [self requestTextWithURLComponentString:[NSString stringWithFormat:articleDetailRequestUrl, self.article.id]];

    // Do any additional setup after loading the view from its nib.
}




-(void)requestTextWithURLComponentString:(NSString *)suffixStr
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *categoryUrl =[NSURL URLWithString:[urlPrefix stringByAppendingPathComponent:suffixStr]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:categoryUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"%@",[NSThread currentThread]);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *strFromData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                //正则表达式里面‘\’,‘[’都是特殊字符，若需要这些字符必须用‘\’转义，而‘\’在oc里同样是转义字符，必须再次转义
                NSString *pattern = @"<!\\[CDATA\\[([^\\]]+)\\]";
                //!\\[CDATA\\[([^\\]]+)\\]
                NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
                NSArray *results = [regex matchesInString:strFromData options:0 range:NSMakeRange(0, strFromData.length)];
                NSMutableAttributedString *attrStr  = [[NSMutableAttributedString alloc] init];

                for (NSTextCheckingResult *result in results) {
                    NSString *cdataStr = [strFromData substringWithRange:result.range];
                    NSRange range1 = [cdataStr rangeOfString:@"CDATA["];
                    NSRange range2 = [cdataStr rangeOfString:@"]"];
                    cdataStr = [cdataStr substringWithRange:(NSRange){range1.location + range1.length,range2.location - range1.location - range1.length}];
                    if ([cdataStr containsString:@"http"]) {
                        cdataStr = [cdataStr stringByReplacingOccurrencesOfString:@";" withString:@"&"];
                        SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
                        [downloader downloadImageWithURL:[NSURL URLWithString:cdataStr] options:0 progress:0 completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                          
                            NSMutableAttributedString *attr = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(240, 140) alignToFont:[UIFont systemFontOfSize:16] alignment:YYTextVerticalAlignmentCenter];
                            [attrStr appendAttributedString: attr];
                        }];
                        NSLog(@"%@",cdataStr);
                    }
                    else
                    {
                        [attrStr appendString:cdataStr];
                    }
                }
                self.articleTextView.attributedText = attrStr;
            });
        }
    }];
    [dataTask resume];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
