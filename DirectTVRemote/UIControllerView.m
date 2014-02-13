//
//  UIControllerView.m
//  DirectTVRemote
//
//  Created by Chris Mays on 6/4/13.
//  Copyright (c) 2013 Chris Mays. All rights reserved.
//

#import "UIControllerView.h"
#import "JSONDictionaryExtensions.h"
@interface UIControllerView ()

@end

@implementation UIControllerView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)createInterface{
    NSLog(@"interface started Veiw Frame %f",self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-20 );
    UIScrollView *scroller=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-20)];
    scroller.bounces=false;
    scroller.contentSize=CGSizeMake(320, 1000);
    UIImage *image=[UIImage imageNamed:@"flatremotetransparent.png"];
    UIImageView *controllerView=[[UIImageView alloc] initWithImage:image];
    controllerView.frame=CGRectMake(0, 0, 320, 1000);
    
    [scroller addSubview:controllerView];
    
    UIButton *powerButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 110, 96, 33)];
    [powerButton addTarget:self action:@selector(powerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    powerButton.showsTouchWhenHighlighted=true;
    
    UIButton *redButton=[[UIButton alloc] initWithFrame:CGRectMake(7, 332, 45, 45)];
    [redButton addTarget:self action:@selector(redButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    redButton.showsTouchWhenHighlighted=true;
    
    UIButton *greenButton=[[UIButton alloc] initWithFrame:CGRectMake(7, 431, 45, 45)];
    [greenButton addTarget:self action:@selector(greenButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    greenButton.showsTouchWhenHighlighted=true;
    
    UIButton *blueButton=[[UIButton alloc] initWithFrame:CGRectMake(266, 332, 45, 45)];
    [blueButton addTarget:self action:@selector(blueButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    blueButton.showsTouchWhenHighlighted=true;
    
    UIButton *yellowButton=[[UIButton alloc] initWithFrame:CGRectMake(266, 431, 45, 45)];
    [yellowButton addTarget:self action:@selector(yellowButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    yellowButton.showsTouchWhenHighlighted=true;

    
    UIButton *activeButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 47, 83, 46)];
    [activeButton addTarget:self action:@selector(activeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    activeButton.showsTouchWhenHighlighted=true;
    
    UIButton *listButton=[[UIButton alloc] initWithFrame:CGRectMake(119, 47, 66, 46)];
    [listButton addTarget:self action:@selector(listButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    listButton.showsTouchWhenHighlighted=true;
    
    UIButton *exitButton=[[UIButton alloc] initWithFrame:CGRectMake(233, 47, 66, 46)];
    [exitButton addTarget:self action:@selector(exitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    exitButton.showsTouchWhenHighlighted=true;
    
    
    UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 121, 83, 46)];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=true;
    
    UIButton *menuButton=[[UIButton alloc] initWithFrame:CGRectMake(119, 121, 66, 46)];
    [menuButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    menuButton.showsTouchWhenHighlighted=true;
    
    UIButton *infoButton=[[UIButton alloc] initWithFrame:CGRectMake(233, 121, 66, 46)];
    [infoButton addTarget:self action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    infoButton.showsTouchWhenHighlighted=true;
    
    
    
    
    
    UIButton *rewindButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 208, 66, 61)];
    [rewindButton addTarget:self action:@selector(rewindButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    rewindButton.showsTouchWhenHighlighted=true;
    
    UIButton *playButton=[[UIButton alloc] initWithFrame:CGRectMake(84, 200, 82, 73)];
    [playButton addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    playButton.showsTouchWhenHighlighted=true;
    
    UIButton *pauseButton=[[UIButton alloc] initWithFrame:CGRectMake(180, 204, 41, 70)];
    [pauseButton addTarget:self action:@selector(pauseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    pauseButton.showsTouchWhenHighlighted=true;
    
    UIButton *fastforwardButton=[[UIButton alloc] initWithFrame:CGRectMake(239, 209, 67, 62)];
    [fastforwardButton addTarget:self action:@selector(fastforwardButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    fastforwardButton.showsTouchWhenHighlighted=true;

    
    
    
    UIButton *chanUpButton=[[UIButton alloc] initWithFrame:CGRectMake(13, 523, 145, 44)];
    [chanUpButton addTarget:self action:@selector(channelUpPressed:) forControlEvents:UIControlEventTouchUpInside];
    chanUpButton.showsTouchWhenHighlighted=true;
    UIButton *chanDownButton=[[UIButton alloc] initWithFrame:CGRectMake(169, 523, 145, 44)];
    [chanDownButton addTarget:self action:@selector(channelDownPressed:) forControlEvents:UIControlEventTouchUpInside];
    chanDownButton.showsTouchWhenHighlighted=true;

    
    
    
    UIButton *oneButton=[[UIButton alloc] initWithFrame:CGRectMake(12, 580, 83, 82)];
    [oneButton addTarget:self action:@selector(oneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    oneButton.showsTouchWhenHighlighted=true;
    UIButton *twoButton=[[UIButton alloc] initWithFrame:CGRectMake(113, 580, 83, 82)];
    [twoButton addTarget:self action:@selector(twoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    twoButton.showsTouchWhenHighlighted=true;
    UIButton *threeButton=[[UIButton alloc] initWithFrame:CGRectMake(217, 580, 83, 82)];
    [threeButton addTarget:self action:@selector(threeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    threeButton.showsTouchWhenHighlighted=true;
    
    
    
    
    UIButton *fourButton=[[UIButton alloc] initWithFrame:CGRectMake(12, 685, 83, 82)];
    [fourButton addTarget:self action:@selector(fourButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    fourButton.showsTouchWhenHighlighted=true;
    UIButton *fiveButton=[[UIButton alloc] initWithFrame:CGRectMake(113, 685, 83, 82)];
    [fiveButton addTarget:self action:@selector(fiveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    fiveButton.showsTouchWhenHighlighted=true;
    UIButton *sixButton=[[UIButton alloc] initWithFrame:CGRectMake(217, 685, 83, 82)];
    [sixButton addTarget:self action:@selector(sixButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    sixButton.showsTouchWhenHighlighted=true;
    
    UIButton *sevenButton=[[UIButton alloc] initWithFrame:CGRectMake(12, 793, 83, 82)];
    [sevenButton addTarget:self action:@selector(sevenButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    sevenButton.showsTouchWhenHighlighted=true;
    UIButton *eightButton=[[UIButton alloc] initWithFrame:CGRectMake(113, 793, 83, 82)];
    [eightButton addTarget:self action:@selector(eightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    eightButton.showsTouchWhenHighlighted=true;
    UIButton *nineButton=[[UIButton alloc] initWithFrame:CGRectMake(217, 793, 83, 82)];
    [nineButton addTarget:self action:@selector(nineButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    nineButton.showsTouchWhenHighlighted=true;
    
    UIButton *zeroButton=[[UIButton alloc] initWithFrame:CGRectMake(119, 892, 83, 82)];
    [zeroButton addTarget:self action:@selector(zeroButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    zeroButton.showsTouchWhenHighlighted=true;
    
    
    
    UIButton *prevButton=[[UIButton alloc] initWithFrame:CGRectMake(12, 893, 83, 82)];
    [prevButton addTarget:self action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    prevButton.showsTouchWhenHighlighted=true;
    
    
    UIButton *selectButton=[[UIButton alloc] initWithFrame:CGRectMake(113, 352, 90, 85)];
    [selectButton addTarget:self action:@selector(selectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    selectButton.showsTouchWhenHighlighted=true;
    
    UIButton *upButton=[[UIButton alloc] initWithFrame:CGRectMake(97, 298, 115, 44)];
    [upButton addTarget:self action:@selector(upButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    upButton.showsTouchWhenHighlighted=true;
    UIButton *leftButton=[[UIButton alloc] initWithFrame:CGRectMake(71, 356, 34, 90)];
    [leftButton addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.showsTouchWhenHighlighted=true;
    UIButton *rightButton=[[UIButton alloc] initWithFrame:CGRectMake(207, 347, 34, 90)];
    [rightButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.showsTouchWhenHighlighted=true;
    UIButton *downButton=[[UIButton alloc] initWithFrame:CGRectMake(120, 446, 90, 34)];
    [downButton addTarget:self action:@selector(downButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    downButton.showsTouchWhenHighlighted=true;
    
    [scroller addSubview:chanUpButton];
    [scroller addSubview:chanDownButton];
    [scroller addSubview:oneButton];
    [scroller addSubview:twoButton];
    [scroller addSubview:threeButton];
    [scroller addSubview:fourButton];
    [scroller addSubview:fiveButton];
    [scroller addSubview:sixButton];
    [scroller addSubview:sevenButton];
    [scroller addSubview:eightButton];
    [scroller addSubview:nineButton];
    [scroller addSubview:zeroButton];
    [scroller addSubview:prevButton];
    [scroller addSubview:rewindButton];
    [scroller addSubview:playButton];
    [scroller addSubview:pauseButton];
    [scroller addSubview:fastforwardButton];
    [scroller addSubview:selectButton];
    [scroller addSubview:upButton];
    [scroller addSubview:leftButton];
    [scroller addSubview:rightButton];
    [scroller addSubview:downButton];
    [scroller addSubview:activeButton];
    [scroller addSubview:listButton];
    [scroller addSubview:exitButton];
    [scroller addSubview:backButton];
    [scroller addSubview:menuButton];
    [scroller addSubview:infoButton];
    [scroller addSubview:redButton];
    [scroller addSubview:blueButton];
    [scroller addSubview:greenButton];
    [scroller addSubview:yellowButton];
    [scroller addSubview:powerButton];
    [self.view addSubview:scroller];
    NSLog(@"interface ended");
    
    
}
- (IBAction)guidePressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=guide&hold=keyPress", ip]];
    NSLog(@"%@",[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=guide&hold=keyPress", ip]);
}

- (IBAction)backPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=back&hold=keyPress", ip]];

}

- (IBAction)infoButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=info&hold=keyPress", ip]];

}

- (IBAction)upButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=up&hold=keyPress", ip]];

}

- (IBAction)downButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=down&hold=keyPress", ip]];

}

- (IBAction)selectButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=select&hold=keyPress", ip]];

}

- (IBAction)leftButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=left&hold=keyPress", ip]];

}

- (IBAction)rightButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=right&hold=keyPress", ip]];

}

- (IBAction)rewindButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=rew&hold=keyPress", ip]];

}

- (IBAction)playButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=play&hold=keyPress", ip]];

}

- (IBAction)pauseButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=pause&hold=keyPress", ip]];

}

- (IBAction)fastforwardButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=ffwd&hold=keyPress", ip]];

}

- (IBAction)recordButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=record&hold=keyPress", ip]];

}

- (IBAction)phoneInfoPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/tv/getTuned", ip]];

}

- (IBAction)channelUpPressed:(id)sender {
 [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=chanup&hold=keyPress", ip]];

}

- (IBAction)channelDownPressed:(id)sender {
     [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=chandown&hold=keyPress", ip]];
}

/**
    Keypad Buttons
 
 */
- (void)oneButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=1&hold=keyPress", ip]];
}
- (void)twoButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=2&hold=keyPress", ip]];
}
- (void)threeButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=3&hold=keyPress", ip]];
}

- (void)fourButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=4&hold=keyPress", ip]];
}
- (void)fiveButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=5&hold=keyPress", ip]];
}
- (void)sixButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=6&hold=keyPress", ip]];
}
- (void)sevenButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=7&hold=keyPress", ip]];
}
- (void)eightButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=8&hold=keyPress", ip]];
}
- (void)nineButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=9&hold=keyPress", ip]];
}
- (void)zeroButtonPressed:(id)sender {
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=0&hold=keyPress", ip]];
}

-(void)previousButtonPressed:(id)sender{
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=prev&hold=keyPress", ip]];
    
}
-(void)activeButtonPressed:(id)sender{
     [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=active&hold=keyPress", ip]];
}
-(void)listButtonPressed:(id)sender{
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=list&hold=keyPress", ip]];
}
-(void)exitButtonPressed:(id)sender{
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=exit&hold=keyPress", ip]];
}

-(void)backButtonPressed:(id)sender{
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=back&hold=keyPress", ip]];
}
-(void)menuButtonPressed:(id)sender{
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=menu&hold=keyPress", ip]];
}

-(void)redButtonPressed:(id)sender{
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=red&hold=keyPress", ip]];
}
-(void)greenButtonPressed:(id)sender{
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=green&hold=keyPress", ip]];
}
-(void)blueButtonPressed:(id)sender{
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=blue&hold=keyPress", ip]];
}
-(void)yellowButtonPressed:(id)sender{
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=yellow&hold=keyPress", ip]];
}
-(void)powerButtonPressed:(id)sender{
    [self makeRequestWithURL:[NSString stringWithFormat:@"http://%@:8080/remote/processKey?key=power&hold=keyPress", ip]];

}

-(void)setIPAddress:(NSString *)ipAdd{
    ip=ipAdd;
}
-(void)setDVR:(NSDVR *)contDVR{
    controllerDVR=contDVR;
}

- (void)viewDidLoad
{    

    [super viewDidLoad];
    NSLog(@"loaded");
    if (controllerDVR!=NULL &&[controllerDVR getDVRName]!=NULL && ![[controllerDVR getDVRName] isEqualToString:@""]) {
        self.title=[controllerDVR getDVRName];
    }
    else{
        self.title=ip;
    }
    [self createInterface];
	// Do any additional setup after loading the view.
}


-(void)makeRequestWithURL:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        NSLog(@"Connection Failed");
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{ // executed when the connection receives data
    
    recievedData = data;
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if(recievedData!=NULL){
    NSDictionary *dictionary = [NSDictionary dictionaryWithJSONData:recievedData];
        if ([[[dictionary objectForKey:@"status"] objectForKey:@"query"] isEqualToString:@"/tv/getTuned"]) {
            [self displayTunedInfoWithDictionary:dictionary];
            
        }
    }
    
    
}
-(void)displayTunedInfoWithDictionary:(NSDictionary *)dict{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"TV Tuned Info" message:[NSString stringWithFormat:@"Channel %@ \n Show: %@", [dict objectForKey:@"major"], [dict objectForKey:@"title"]] delegate:self cancelButtonTitle:@"OK!" otherButtonTitles: nil];
    [alert show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
