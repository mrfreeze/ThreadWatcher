//
//  ObjcEvilDoers.m
//  moreTabs
//
//  Created by Mr. Freeze on 25/01/2010.
//  Copyright 2010 Mr. Freeze. All rights reserved.
//
// Based on "objc-method-swizzle.mm" from the Chromium project
// Copyright (c) 2009 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

#import "ObjcEvilDoers.h"
#import <objc/runtime.h>


Method GetImplementedInstanceMethod(Class aClass, SEL aSelector) 
{
	Method method = NULL;
	unsigned int methodCount = 0;
	Method* methodList = class_copyMethodList(aClass, &methodCount);
	if (methodList) 
	{
		for (unsigned int i = 0; i < methodCount; ++i) 
		{
			if (method_getName(methodList[i]) == aSelector) 
			{
				method = methodList[i];
				break;
			}
		}
		free(methodList);
	}
	return method;
}

// swizzle the methods fo' shizzle my nizzle
IMP SwizzleImplementedInstanceMethods(Class aClass, const SEL originalSelector, const SEL alternateSelector) 
{
	// The methods must both be implemented by the target class, not
	// inherited from a superclass.
	Method original = GetImplementedInstanceMethod(aClass, originalSelector);
	Method alternate = GetImplementedInstanceMethod(aClass, alternateSelector);

	if (!original || !alternate)
		return NULL;
	
	// The argument and return types must match exactly.
	const char* originalTypes = method_getTypeEncoding(original);
	const char* alternateTypes = method_getTypeEncoding(alternate);


	if (!originalTypes || !alternateTypes ||
		strcmp(originalTypes, alternateTypes))
		return NULL;
	
	IMP ret = method_getImplementation(original);
	if (ret)
		method_exchangeImplementations(original, alternate);

	return ret;
}

