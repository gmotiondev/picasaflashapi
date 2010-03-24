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
import flash.utils.Dictionary;
/**
 * 
 */
public class EntryFactory 
{
	private static var __factoryMap : Dictionary;
	
	private function get factoryMap() : Dictionary
	{
		if(__factoryMap == null)
		{
			__factoryMap = new Dictionary();
			__factoryMap[KindType.USER] = UserEntry;
			__factoryMap[KindType.ALBUM] = AlbumEntry;
			__factoryMap[KindType.PHOTO] = PhotoEntry;
			__factoryMap[KindType.TAG] = TagEntry;
			__factoryMap[KindType.COMMENT] = CommentEntry;
		}
		
		return __factoryMap;
	}
	
	public function createEntry(type : KindType, xml : XML) : Entry
	{
		if(factoryMap[type] == null)
		{
			throw new ArgumentError("Cannot create entry, unknown type: \"" + type + "\"");
		}
		
		var entryClass : Class = factoryMap[type];
		var entry : Entry = new entryClass(xml);

		return entry;
	}
}
}