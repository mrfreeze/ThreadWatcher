//
//  ObjcEvilDoers.h
//  moreTabs
//
//  Created by Mr. Freeze on 25/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "objc-method-swizzle.h" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import <Cocoa/Cocoa.h>
#import <objc/objc-class.h>

// Do not use these things. If you think using something in this file is a good idea, stop, turn 360º, walk away, and give it some serious thought. The code was written by Satan himself with the blood of new born babies.

Method GetImplementedInstanceMethod(Class aClass, SEL aSelector);
IMP SwizzleImplementedInstanceMethods(Class aClass, const SEL originalSelector, const SEL alternateSelector);
