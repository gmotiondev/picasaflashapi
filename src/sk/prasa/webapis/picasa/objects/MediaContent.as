/*
 * The MIT License
 * 
 * Copyright (c) 2008 Michal Gron (michal.gron@gmail.com)
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

package sk.prasa.webapis.picasa.objects 
{
/**
 * 
 */
public class MediaContent 
{
	public var url : String;
	public var type : String;
	public var medium : String;
	public var height : Number;
	public var width : Number;
	public var fileSize : Number;
	
	public function MediaContent(url : String = null, 
								 type : String = null, 
								 medium : String = null, 
								 height : Number = 0, 
								 width : Number = 0, 
								 size : Number = 0)
	{
		this.url = url;
		this.type = type;
		this.medium = medium;
		this.height = height;
		this.width = width;
		this.fileSize = size;
	}
	
	/**
	 * @inheritDoc
	 */
	public function toString() : String
	{
		return  "[MediaContent " +
				"url=" + url + 
				", type=" + type + 
				", medium=" + medium + 
				", height=" + height + 
				", width=" + width + 
				", fileSize=" + fileSize + 
				"]";	
	}
}
}