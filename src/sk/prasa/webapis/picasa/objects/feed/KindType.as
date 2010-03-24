/*
 * The MIT License
 * 
 * Copyright (c) 2009 Michal Gron (michal.gron@gmail.com)
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
package sk.prasa.webapis.picasa.objects.feed 
{
import sk.prasa.webapis.picasa.objects.Kind;
/**
 * 
 */
public class KindType 
{
	public static var NONE : KindType = 	new KindType("none", -1);
	public static var USER : KindType = 	new KindType(Kind.USER, 0);
	public static var ALBUM : KindType = 	new KindType(Kind.ALBUM, 1);
	public static var PHOTO : KindType = 	new KindType(Kind.PHOTO, 2);
	public static var TAG : KindType = 		new KindType(Kind.TAG, 3);
	public static var COMMENT : KindType = 	new KindType(Kind.COMMENT, 4);
	
	public var value : String;
	public var ordinal : int;
		
	public function KindType(value : String, ordinal : int)
	{
		this.value = value;
		this.ordinal = ordinal;
	}
	
	/**
	 * 
	 */
	public static function fromString(typeString : String) : KindType
	{
		var instance : KindType;
		
		for each(var item : KindType in list)
		{
			if(item.value == typeString) instance = item;	
		}	
		
		if(instance == null)
		{
			// e.g. the featured feed doesn't have the category tag!
			//throw new ArgumentError("String does not match an existing kind type: " + typeString);
			instance = KindType.NONE;
		}
		
		return instance;
	}
	
	/**
	 * 
	 */
	public static function get list() : Array
	{
		return [KindType.USER, 
				KindType.ALBUM,
				KindType.PHOTO,
				KindType.TAG,
				KindType.COMMENT];
	}

	/**
	 * 
	 */
	public function equals(enum : KindType) : Boolean
	{
		return (this.ordinal == enum.ordinal && this.value == enum.value);
	}
	
	/**
	 * 
	 */
	public function toString() : String
	{
		return "[object KindType(\"" + value + "\", \"" + ordinal + "\")]";
	}
}
}