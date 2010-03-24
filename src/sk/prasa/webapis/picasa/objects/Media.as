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
import sk.prasa.webapis.picasa.objects.FeedElement;
import sk.prasa.webapis.picasa.objects.Namespaces;
/**
 * Picasa Web Albums uses the media (http://search.yahoo.com/mrss/) namespace 
 * for elements defined in the Media RSS specification. 
 * For information about the media namespace, see the Media RSS specification
 * (http://search.yahoo.com/mrss).
 */
public class Media extends FeedElement
{		
	private var media_ns : Namespace = Namespaces.MEDIA_NS;
	
	public function Media(data : XML)
	{
		super(data);
	}
	
	/**
	 * Contains the URL and other information about the full version 
	 * of the entry's media content.
	 * 
	 * // TODO:
	 * // There can be multiple <media:content> elements for a given <media:group>
	 */
	public function get content() : MediaContent
	{
		var tM : MediaContent = new MediaContent();
			tM.url = Utils.parseString(this.data.media_ns::group.media_ns::content.@url);
			tM.type = Utils.parseString(this.data.media_ns::group.media_ns::content.@type);
			tM.medium = Utils.parseString(this.data.media_ns::group.media_ns::content.@medium);
			tM.width = Utils.parseNumber(this.data.media_ns::group.media_ns::content.@width);
			tM.height = Utils.parseNumber(this.data.media_ns::group.media_ns::content.@height);
			tM.fileSize = Utils.parseNumber(this.data.media_ns::group.media_ns::content.@fileSize);
		
		return tM;
	}
	
	/**
	 * @private
	 */
	public function set content(value : MediaContent) : void
	{
		// TODO: ...
	}
	
	/**
	 * Contains the nickname of the user who created the content. 
	 * This is a user-specified value that should be used when referring to the 
	 * user by name.
	 */
	public function get credit() : String
	{
		return Utils.parseString(this.data.media_ns::group.media_ns::["credit"]);
	}
	
	/**
	 * @private
	 */
	public function set credit(value : String) : void
	{
		// TODO: ...
	}
	
	/**
	 * Contains a description of the entry's media content. For api projections, 
	 * the description is in plain text; for base projections, the description 
	 * is in HTML. 
	 * 
	 * This field is limited to 1024 characters. 
	 * The description can contain UTF-8 characters.
	 */
	public function get description() : String
	{
		return Utils.parseString(this.data.media_ns::group.media_ns::["description"]);
	}
	
	/**
	 * @private
	 */
	public function set description(value : String) : void
	{
		// TODO: ...
	}
	
	/**
	 * Lists the tags associated with the entry. 
	 * Contains a list of tags that have been added to the photo, 
	 * or all tags that have been added to photos in the album.
	 *  
	 * Tags are limited to 128 characters and 100 tags per item. 
	 * Tags use the UTF-8 character set, so they are not limited to ASCII.
	 */
	public function get keywords() : Array
	{
		var tKeywords : String = Utils.parseString(this.data.media_ns::group.media_ns::["keywords"]); 
		
		return tKeywords != null ? tKeywords.split(" ").join("").split(",") : [];
	}
	
	/**
	 * @private
	 */
	public function set keywords(value : Array) : void
	{
		// TODO: ...
	}
	
	/**
	 * Contains the URL of a thumbnail of a photo or album cover. 
	 * If the thumbsize parameter is set, this element points to thumbnails 
	 * of the requested sizes; otherwise the thumbnails are the 
	 * default thumbnail size.
	 * 
	 * There can be multiple <media:thumbnail> elements for a given <media:group>; 
	 * for example, a given item may have multiple thumbnails at different sizes. 
	 * Photos generally have two thumbnails at different sizes; 
	 * albums generally have one cropped thumbnail.
	 */
	public function get thumbnails() : Array
	{
		var tRes : Array = [];
		
		// e.g. when parsed from photo as parent, album doesn't have media:group
		try
		{
			for each(var thumb : XML in this.data.media_ns::group.media_ns::thumbnail)
			{
				tRes.push(new MediaThumbnail(
							Utils.parseString(thumb.@url), 
							Utils.parseNumber(thumb.@width), 
							Utils.parseNumber(thumb.@height))); 
			}
		}
		catch(e : Error)
		{
			//tRes = [];
		}
		finally
		{
			return tRes;
		}
	}
	
	/**
	 * @private
	 */
	public function set thumbnails(value : Array) : void
	{
		// TODO: ..
	}
	
	/**
	 * Returns first thumb from the thumbnails array
	 */
	public function get thumbnail() : MediaThumbnail
	{
		return thumbnails[0] as MediaThumbnail;
	}
	
	/**
	 * Contains the title of the entry's media content, in plain text.
	 */
	public function get title() : String
	{
		return Utils.parseString(this.data.media_ns::group.media_ns::["title"]);
	}
	
	/**
	 * @private
	 */	
	public function set title(value : String) : void
	{
		// TODO: ...
	}
	
	/**
	 * @inheritDoc
	 */
	public function toString() : String
	{
		// TODO: Get rid of this try/catch please!
		
		try
		{
			return  "[Media " +
					" content=" + content.toString() + 
					", credit=" + credit + 
					", description=" + description + 
					", keywords=" + keywords.join(",") + 
					", thumbnails=" + thumbnails.join(", ") + 
					", title=" + title + 
					"]";
		}
		catch(e : Error)
		{
			// e.g. when parsed from photo as parent, album doesn't have media:group
			return "Error Media.toString();: " + e.message;
		}
		
		return null;
	}
}
}