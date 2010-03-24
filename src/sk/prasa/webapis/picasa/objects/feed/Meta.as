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
import sk.prasa.webapis.picasa.objects.FeedElement;
import sk.prasa.webapis.picasa.objects.Generator;
import sk.prasa.webapis.picasa.objects.Link;
import sk.prasa.webapis.picasa.objects.Links;
import sk.prasa.webapis.picasa.objects.Namespaces;
import sk.prasa.webapis.picasa.objects.Utils;
import sk.prasa.webapis.picasa.objects.feed.IMeta;
/**
 * 
 */
public class Meta extends FeedElement implements IMeta 
{
	private var atom_ns : Namespace = Namespaces.ATOM_NS;

	public function Meta(data : XML)
	{
		super(data);
	}
	
	/**
	 * Feed ID	/feed/id	/rss/channel/atom:id
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
		// TODO: ... create id node on this.data!
	}

	/**
	 * Feed Title	/feed/title	/rss/channel/title
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
	 * Feed HTML Link	/feed/link[@rel="alternate"]\	/rss/channel/link
	 * 					[@type="text/html"]/@href
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
	 * Feed Description		/feed/subtitle		/rss/channel/description
	 */
	public function get subtitle() : String
	{
		return Utils.parseString(this.data.atom_ns::subtitle);
	}

	/**
	 * @private
	 */
	public function set subtitle(value : String) : void
	{
		// TODO: ... create subtitle node on this.data! 
	}
	
	/**
	 * Feed Copyright	/feed/rights	/rss/channel/copyright
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
	 * Feed Last Update Date	/feed/updated		/rss/channel/lastBuildDate
	 * 							(RFC 3339 format)	(RFC 822 format)
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
		// TODO: ... create updated node on this.data!
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
	 * Feed Generator	/feed/generator				/rss/channel/generator
	 * 					/feed/generator/@uri	
	 */
	public function get generator() : Generator
	{
		var tGenerator : Generator = new Generator();
			tGenerator.uri = Utils.parseString(this.data.atom_ns::generator.@uri);
			tGenerator.version = Utils.parseString(this.data.atom_ns::generator.@version);
			tGenerator.value = Utils.parseString(this.data.atom_ns::generator);
		
		return tGenerator;
	}

	/**
	 * @private
	 */
	public function set generator(value : Generator) : void
	{
		// TODO: ... create generator node on this.data!
	}

	/**
	 * Feed Icon	/feed/icon	/rss/channel/image/url (unless there's also a logo, 
	 * 							in which case the icon isn't included in the feed)
	 */
	public function get icon() : String
	{
		return Utils.parseString(this.data.atom_ns::icon);
	}

	/**
	 * @private
	 */
	public function set icon(value : String) : void
	{
		// TODO: ... create icon node on this.data!
	}

	/**
	 * Feed Logo	/feed/logo	/rss/channel/image/url
	 */
	public function get logo() : String
	{
		return Utils.parseString(this.data.atom_ns::logo);
	}

	/**
	 * @private
	 */
	public function set logo(value : String) : void
	{
		// TODO: ... create logo node on this.data!
	}
}
}
