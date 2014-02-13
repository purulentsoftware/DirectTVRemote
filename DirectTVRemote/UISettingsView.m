//
//  UISettingsView.m
//  DirectTVRemote
//
//  Created by Chris Mays on 6/8/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import "UISettingsView.h"
#import "NSDVRSettings.h"
@interface UISettingsView ()

@end

@implementation UISettingsView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSDVRSettings *settings=[NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"Settings"]];
    NSArray *ipTemp=[[settings getTemplateIP] componentsSeparatedByString:@"."];
    if([ipTemp count]==3){
        begginingIPField.text=[ipTemp objectAtIndex:0];
        secondIPField.text=[ipTemp objectAtIndex:1];
        thirdIPField.text=[ipTemp objectAtIndex:2];
    }
    startRangeIPField.text=[NSString stringWithFormat:@"%d",[settings getStartRange]];
    endRangeIPField.text=[NSString stringWithFormat:@"%d",[settings getEndRange]];
    [scanSpeedSegment setSelectedSegmentIndex:[settings getScanSpeed]];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)returnButtonPressed:(id)sender{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSDVRSettings *settings=[NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"Settings"]];
    [settings setStartRange:[startRangeIPField.text intValue]];
    [settings setEndRange:[endRangeIPField.text intValue]];
    [settings setTemplateIPWithString:[NSString stringWithFormat:@"%@.%@.%@",begginingIPField.text, secondIPField.text,thirdIPField.text]];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:settings];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:data forKey:@"Settings"];
    [def synchronize];
    [begginingIPField resignFirstResponder];
    [secondIPField resignFirstResponder];
    [thirdIPField resignFirstResponder];
    [startRangeIPField resignFirstResponder];
    [endRangeIPField resignFirstResponder];
}

- (IBAction)scanSpeedChanged:(id)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSDVRSettings *settings=[NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"Settings"]];
    [settings setScanSpeedWithSpeed:[scanSpeedSegment selectedSegmentIndex]];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:settings];
    [defaults setObject:data forKey:@"Settings"];
}


@end
