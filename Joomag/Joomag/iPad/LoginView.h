//
//  LoginView.h
//  Joomag
//
//  Created by Armen Abrahamyan on 10/20/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponseTrackerDelegate.h"

@interface LoginView : UIView <UITextFieldDelegate, ResponseTrackerDelegate>{
    
    UITextField * emailTextField;
    UITextField * fgEmailTextField;
    UITextField * passwordTextField;    

    UIView * loginContainer;
    UIView * forgotPasswordContainer;

}   

@end
