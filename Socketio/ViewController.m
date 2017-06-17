//
//  ViewController.m
//  Socketio
//
//  Created by sakamotomasakiyo on 2017/06/17.
//  Copyright © 2017年 saka. All rights reserved.
//

#import "ViewController.h"

@import SocketIO;

@interface ViewController ()

@property (nonatomic) SocketIOClient *socket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSURL* url = [[NSURL alloc] initWithString:@"http://localhost:8080"];
    self.socket = [[SocketIOClient alloc] initWithSocketURL:url config:@{@"log": @YES, @"forcePolling": @YES}];
    
    // 接続
    [self.socket on:@"connect" callback:^(NSArray *data, SocketAckEmitter *ack) {
        NSLog(@"socket connected");
    }];
    
    // 切断
    [self.socket on:@"disconnect" callback:^(NSArray *data, SocketAckEmitter *ack) {
        NSLog(@"socket disconnect");
    }];
    
    // サーバからのメッセージ受信
    [self.socket on:@"from_server" callback:^(NSArray *data, SocketAckEmitter *ack) {
        for (NSString *item in data) {
            NSLog(@"%@", item);
        }
    }];
    
    [self.socket connect];
}

- (IBAction)sendEmit:(id)sender {
    
    // サーバーへのメッセージ送信(Ackを無視)
    [self.socket emit:@"from_client" with:@[@"hello!"]];
}

- (IBAction)sendEmitWithAck:(id)sender {
    
    // サーバーへのメッセージ送信(Ackを監視)
    OnAckCallback *ack = [self.socket emitWithAck:@"from_client_want_ack" with:@[@"hello! (require ack)"]];
    [ack timingOutAfter:3.0 callback:^(NSArray * _Nonnull data) {
        // Ackを受信時にコールバック
        // もしAckを受信しなければ3秒後にコールバック（この場合のitemsは@"NO ACK"を含む）
        for (NSString *item in data) {
            NSLog(@"%@", item);
        }
    }];
}

@end
