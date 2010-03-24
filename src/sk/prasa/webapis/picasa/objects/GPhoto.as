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
 * 
 */
public class GPhoto extends FeedElement
{
	public var kind : String;
 
	// multiple kinds
	public var albumid : String;			// gphoto:albumid
	public var id : String;					// gphoto:id
	
	// user kind
	public var maxPhotosPerAlbum : uint;	// gphoto:maxPhotosPerAlbum = only if authenticated user is owner
	public var nickname : String;			// gphoto:nickname
	public var quotacurrent : Number;		// gphoto:quotacurrent = only if authenticated user is owner
	public var quotalimit : Number;			// gphoto:quotalimit = only if authenticated user is owner
	public var thumbnail : String;			// gphoto:thumbnail
	public var user : String;				// gphoto:user
	
	// album kind
	public var access : String; 			// gphoto:access = public or private
	public var bytesUsed : uint; 			// gphoto:bytesUsed = only if authenticated user is owner 
	public var location : String; 			// gphoto:location
	public var numphotos : uint; 			// gphoto:numphotos
	public var numphotosremaining : uint;	// gphoto:numphotosremaining	= only if authenticated user is owner

	// photo kind
	public var checksum : String;			// gphoto:checksum
	public var commentCount : uint;			// gphoto:commentCount
	public var height : Number;				// gphoto:height
	public var rotation : uint;				// gphoto:rotation
	public var size : Number;				// gphoto:size
	public var timestamp : Number;			// gphoto:timestamp = identical with exif:time
	public var videostatus : String;		// gphoto:videostatus = pending, ready, final, failed
	public var width : Number;				// gphoto:width

	// appear in photo entries search result feeds
	public var albumtitle : String;			// gphoto:albumtitle
	public var albumdesc : String;			// gphoto:albumdesc
	public var snippet : String;			// gphoto:snippet
	public var snippettype : String;		// gphoto:snippettype = PHOTO_DESCRIPTION, PHOTO_TAGS, ALBUM_TITLE, ALBUM_DESCRIPTION, or ALBUM_LOCATION
	public var truncated : Boolean;			// gphoto:truncated
	 
	// comment kind
	public var photoid : String; 			// gphoto:photoid
	
	// tag kind
	public var weight : uint; 				// gphoto:weight = default is 1
	
	private var gphoto_ns : Namespace = Namespaces.GPHOTO_NS;

	public function GPhoto(data : XML, k : String)
	{	
		super(data);
		
		kind = k;
		
		// multiple kind
		albumid 			= Utils.parseString(this.data.gphoto_ns::albumid); 
		id 					= Utils.parseString(this.data.gphoto_ns::id);
		
		switch(kind)
		{
			case Kind.USER:
				maxPhotosPerAlbum = Utils.parseUint(this.data.gphoto_ns::maxPhotosPerAlbum); 
				nickname 	= Utils.parseString(this.data.gphoto_ns::nickname); 
				quotacurrent= Utils.parseNumber(this.data.gphoto_ns::quotacurrent); 
				quotalimit 	= Utils.parseNumber(this.data.gphoto_ns::quotalimit); 
				thumbnail 	= Utils.parseString(this.data.gphoto_ns::thumbnail); 
				user 		= Utils.parseString(this.data.gphoto_ns::user);
				break;
				
			case Kind.ALBUM: 	
				access 		= Utils.parseString(this.data.gphoto_ns::access); 
				bytesUsed 	= Utils.parseUint(this.data.gphoto_ns::bytesUsed); 
				location 	= Utils.parseString(this.data.gphoto_ns::location); 
				numphotos 	= Utils.parseUint(this.data.gphoto_ns::numphotos); 
				numphotosremaining = Utils.parseUint(this.data.gphoto_ns::numphotosremaining);
				break;
				
			case Kind.PHOTO: 
				checksum 	= Utils.parseString(this.data.gphoto_ns::checksum);
				commentCount= Utils.parseUint(this.data.gphoto_ns::commentCount);
				height 		= Utils.parseNumber(this.data.gphoto_ns::height); 
				rotation 	= Utils.parseUint(this.data.gphoto_ns::rotation); 
				size 		= Utils.parseNumber(this.data.gphoto_ns::size); 
				timestamp 	= Utils.parseNumber(this.data.gphoto_ns::timestamp); 
				videostatus = Utils.parseString(this.data.gphoto_ns::videostatus);
				width 		= Utils.parseNumber(this.data.gphoto_ns::width);
				
				// photo entries search result feed
				albumtitle 	= Utils.parseString(this.data.gphoto_ns::albumtitle);
				albumdesc	= Utils.parseString(this.data.gphoto_ns::albumdesc);
				snippet  	= Utils.parseString(this.data.gphoto_ns::snippet);
				snippettype = Utils.parseString(this.data.gphoto_ns::snippettype);
				truncated 	= Utils.parseBoolean(this.data.gphoto_ns::truncated);
				break;
				
			case Kind.TAG:
				weight = Utils.parseUint(this.data.gphoto_ns::weight);
				break;
				
			case Kind.COMMENT: 
				photoid = Utils.parseString(this.data.gphoto_ns::photoid);
				break;
				
			default: 
				break; 
		}
	}
	
	/**
	 * @inheritDoc
	 */
	public function toString() : String
	{
		var tRes : String = "" +
			" albumid=" + albumid +
			", id=" + id;
	
		switch(kind)
		{
				
			case Kind.USER:
				tRes +=	", maxPhotosPerAlbum=" + maxPhotosPerAlbum + 
						", nickname=" + nickname +
						", quotacurrent=" + quotacurrent +
						", quotalimit=" + quotalimit +
						", thumbnail=" + thumbnail +
						", user=" + user;
				break;
			
			case Kind.ALBUM: 
				tRes += ", access=" + access +
						", bytesUsed=" + bytesUsed +
						", location=" + location +
						", numphotos=" + numphotos +
						", numphotosremaining=" + numphotosremaining;
				break;
				
			case Kind.PHOTO:
				tRes += ", checksum=" + checksum +
						", commentCount=" + commentCount +
						", height=" + height +
						", rotation=" + rotation +
						", size=" + size +
						", timestamp=" + timestamp +
						", videostatus=" + videostatus +
						", width=" + width;
						
				// photo entries search result feed
				tRes += ", albumtitle=" + albumtitle +
						", albumdesc=" + albumdesc +
						", snippet=" + snippet +
						", snippettype=" + snippettype +
						", truncated=" + truncated;
				break;
				
			case Kind.TAG:
				tRes += ", weight=" + weight;
				break;
				 
			case Kind.COMMENT:
				tRes += ", photoid=" + photoid;
				break; 
		}
		
		return "[GPhoto " + tRes + "]";
	}			
}
}