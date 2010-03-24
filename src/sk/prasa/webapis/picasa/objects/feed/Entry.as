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
import sk.prasa.webapis.picasa.objects.Author;
import sk.prasa.webapis.picasa.objects.Category;
import sk.prasa.webapis.picasa.objects.Content;
import sk.prasa.webapis.picasa.objects.FeedElement;
import sk.prasa.webapis.picasa.objects.Link;
import sk.prasa.webapis.picasa.objects.Links;
import sk.prasa.webapis.picasa.objects.Namespaces;
import sk.prasa.webapis.picasa.objects.Text;
import sk.prasa.webapis.picasa.objects.Utils;
/**
 * Entry, Data API entry
 * 
 * http://code.google.com/apis/gdata/docs/2.0/reference.html
 */
public class Entry extends FeedElement implements IEntry 
{	
	private var atom_ns : Namespace = Namespaces.ATOM_NS;
	private var xhtml_ns : Namespace = Namespaces.XHTML_NS;
	
	public function Entry(data : XML)
	{
		super(data);
	}
	
	/**
	 * Entry ID	/feed/entry/id	/rss/channel/item/guid
	 */
	public function get id() : String
	{
		return Utils.parseString(this.data.atom_ns::id);
	}
	
	/**
	 * @private
	 */
	public function set id(value : String) : void
	{
		// TODO: ...
	}
	
	/**
	 * Entry Title	/feed/entry/title	/rss/channel/item/title
	 */
	public function get title() : String
	{
		return Utils.parseString(this.data.atom_ns::title);
	}
	
	/**
	 * @private
	 */
	public function set title(value : String) : void
	{
		// TODO: ... create title node on this.data! 
	}
	
	/**
	 * Entry Link	/feed/entry/link	/rss/channel/item/link
	 *									/rss/channel/item/enclosure
	 *									/rss/channel/item/comments
	 *									
	 *				/feed/link[@rel="alternate"][@type="text/html"]@href
	 */
	public function get links() : Links
	{
		var tLinks : Links = new Links();
		
		for each(var node : XML in this.data.atom_ns::link)
		{
			var tLink : Link = new Link();
			tLink.rel = Utils.parseString(node.@rel);
			tLink.type = Utils.parseString(node.@type);
			tLink.hreflang = Utils.parseString(node.@hreflang);
			tLink.href = Utils.parseString(node.@href);
			tLink.title = Utils.parseString(node.@title);
			tLink.length = Utils.parseNumber(node.@["length"]);
			
			tLinks.push(tLink);
		}
		
		return tLinks;
	}
	
	/**
	 * @private
	 */
	public function set links(value : Links) : void
	{
		// TODO: ...
	}
	
	/**
	 * Entry Summary	/feed/entry/summary 	/rss/channel/item/atom:summary
	 * (Required in certain cases; see Atom specification.)	
	 */
	public function get summary() : String
	{
		return Utils.parseString(this.data.atom_ns::summary);
	}
	
	/**
	 * @private
	 */
	public function set summary(value : String) : void
	{
		// TODO: ...
	}
	
	/**
	 * Entry Content	/feed/entry/content		/rss/channel/item/description
	 * (If no content element, then entry must contain at least 
	 * one <link rel="alternate"> element.)
	 */
	public function get content() : Content
	{
		var tContent : Content = new Content();
			tContent.type = Utils.parseString(this.data.atom_ns::content.@type);
			tContent.src = Utils.parseString(this.data.atom_ns::content.@src);
		
		// TODO: check this please!
		if(tContent.type == Text.TYPE_XHTML)
		{
			tContent.value = Utils.parseString(this.data.atom_ns::content.xhtml_ns::div);
		} 
		else
		{
			tContent.value = Utils.parseString(this.data.atom_ns::content);
		}
		
		return tContent;
	}
	
	/**
	 * @private
	 */
	public function set content(value : Content) : void
	{
		// TODO: ...
	}
	
	/**
	 * Feed Author	/feed/author/name		/rss/channel/managingEditor
	 * 				/feed/author/email
	 * 				
	 * 	(Required in certain cases; see Atom specification.)
	 */
	 public function get author() : Author
	{
		var tAuthor : Author = new Author();
			tAuthor.name = Utils.parseString(this.data.atom_ns::author.atom_ns::["name"]);
			tAuthor.email = Utils.parseString(this.data.atom_ns::author.atom_ns::email);
			tAuthor.uri = Utils.parseString(this.data.atom_ns::author.atom_ns::uri);
		
		return tAuthor;
	}

	/**
	 * @private
	 */
	public function set author(value : Author) : void
	{
		// TODO: ... create author nodes on this.data!
	}
	
	/**
	 * Feed Category	/feed/category/@term	/rss/channel/category
	 * Feed Category 	/feed/category/@scheme	/rss/channel/category/@domain
	 * Scheme
	 */
	public function get category() : Category
	{
		var tCategory : Category = new Category();
			tCategory.term = Utils.parseString(this.data.atom_ns::category.@term);
			tCategory.scheme = Utils.parseString(this.data.atom_ns::category.@scheme);
			tCategory.label = Utils.parseString(this.data.atom_ns::category.@label);
		
		return tCategory;
	}

	/**
	 * @private
	 */
	public function set category(value : Category) : void
	{
		// TODO: ... create categories nodes on this.data!
	}
	
	/**
	 * Entry Publication Date	/feed/entry/published	/rss/channel/item/pubDate
	 * 							(RFC 3339)				(RFC 822)
	 */
	public function get published() : Date
	{
		return Utils.parseDate(this.data.atom_ns::published, Utils.parseW3CDTF);
	}
	
	/**
	 * @private
	 */
	public function set published(value : Date) : void
	{
		// TODO: ...
	}
	
	/**
	 * Entry Update Date	/feed/entry/updated		/rss/channel/item/atom:updated
	 * 						(RFC 3339)				(RFC 3339)
	 */
	public function get updated() : Date
	{
		return Utils.parseDate(this.data.atom_ns::updated, Utils.parseW3CDTF);
	}

	/**
	 * @private
	 */
	public function set updated(value : Date) : void
	{
		// TODO: ... 
	}
	
	/**
	 * // TODO: is not in the entry reference
	 */
	public function get rights() : String
	{
		return Utils.parseString(this.data.atom_ns::rights);
	}

	/**
	 * @private
	 */
	public function set rights(value : String) : void
	{
		// TODO: ... create rights node on this.data!
	}
		
//	public function get source() : Head
//	{
//		return new Head(XMLList(this.data.atom_ns::source));
//	} 
}
}
