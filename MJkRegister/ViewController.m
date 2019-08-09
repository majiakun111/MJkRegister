//
//  ViewController.m
//  MJkRegister
//
//  Created by Ansel on 2019/8/9.
//  Copyright © 2019 Ansel. All rights reserved.
//

#import "ViewController.h"
#import "MJKMacros.h"
#import "MJKRegister.h"

@interface ViewController ()

@end

@implementation ViewController

MJK_STRING_EXPORT("stringKey", "string");
MJK_STRINGS_EXPORT("stringsKey", "string1");
MJK_STRINGS_EXPORT("stringsKey", "string2");

MJK_CLASS_EXPORT("class_export_key", ViewController);
MJK_CLASSES_EXPORT("classes_export_key", ViewController);
MJK_CLASSES_EXPORT("classes_export_key", ViewController);

MJK_FUNCTIONS_EXPORT("func")() {
    NSLog(@"---func---");
}

+ (void)test {
    MJK_METHODS_EXPORT("method");
    NSLog(@"Test for method export");
}

+ (void)classExportTest {
    NSLog(@"class export test");
}

+ (void)classesExportTest {
    NSLog(@"classes export test");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", [[MJKRegister sharedInstance] stringForKey:@"stringKey"]);
    NSLog(@"%@", [[MJKRegister sharedInstance] stringArrayForKey:@"stringsKey"]);

    [[[MJKRegister sharedInstance] classForKey:@"class_export_key"] classExportTest];
    [[[MJKRegister sharedInstance] classArrayForKey:@"classes_export_key"] enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj classesExportTest];
    }];
    
    [[MJKRegister sharedInstance] executeArrayForKey:@"func"];

    [[MJKRegister sharedInstance] executeArrayForKey:@"method"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
