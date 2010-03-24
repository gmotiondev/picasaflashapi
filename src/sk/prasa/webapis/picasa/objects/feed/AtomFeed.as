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

package sk.prasa.webapis.picasa.objects.feed 
{
import sk.prasa.webapis.picasa.objects.Namespaces;
import sk.prasa.webapis.picasa.objects.feed.Parser;
/**
 * 
 */
public class AtomFeed extends Parser implements IAtom 
{
	private var __meta : Meta;
	private var __entries : Array;		//[ArrayElementType("sk.prasa.webapis.picasa.objects.feed.Entry")]
	private var __metaFactory : MetaFactory;
	private var __entryFactory : EntryFactory;
	
	private var atom_ns : Namespace = Namespaces.ATOM_NS;
	
	/**
	 * AtomFeed constructor.
	 * 
	 * @param xml XML Pass XML data to the constructor, to have it available in the this.data property 
	 */
	public function AtomFeed(xml : XML)
	{
	 	super(xml);
	 	
	 	// TODO: this is now here, but can be better injected!
		__metaFactory = new MetaFactory();
		__entryFactory = new EntryFactory();
		
		setupMeta();
		setupEntries();
	}

	/**
	 * // TODO: move to MetaFactory!
	 */
	public function get meta() : Meta
	{	
		return __meta;
	}
	
	/**
	 * @private
	 */
	public function set meta(value : Meta) : void
	{
		// TODO: ...
	}
		
	/**
	 * // todo: a Entries class with find() method?
	 * //		filter() method?	 
	 */
	public function get entries() : Array
	{	
		return __entries;
	}
	
	public function get entry() : Entry
	{	 
		return __entries[0];
	}

	/**
	 * 
	 */
	public function set entries(aEntries : Array) : void
	{
		// TODO: ...
	}
	
	/**
	 * @private 
	 */
	protected function setupMeta() : void
	{
		var type : KindType = KindType.fromString(data.atom_ns::category.@term);
		
		__meta = __metaFactory.createMeta(type, data);
	}
	
	/**
	 * @private
	 */
	protected function setupEntries() : void
	{
		var entry : Entry;
		var type : KindType;
		
		__entries = [];
		
		for each (var node : XML in this.data.atom_ns::entry)
		{
			type = KindType.fromString(node.atom_ns::category.@term);
			entry = __entryFactory.createEntry(type, node);
			
			__entries.push(entry);
		}
		
		// if the root tag is <entry> (and not <feed>);
		if(this.data.localName() == "entry")
		{
			type = KindType.fromString(data.atom_ns::category.@term);
			entry = __entryFactory.createEntry(type, data);
			
			__entries.push(entry);
		}
	}
}
}
