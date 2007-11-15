﻿/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.Base;
import sk.prasa.webapis.picasa.Content;
import sk.prasa.webapis.picasa.Exif;
import sk.prasa.webapis.picasa.GPhoto;
import sk.prasa.webapis.picasa.KindType;
import sk.prasa.webapis.picasa.Media;

class sk.prasa.webapis.picasa.Photo extends Base
{
	private var __summary:String;
	private var __content:Content;
	private var __published:String;
	private var __gphoto:GPhoto;
	private var __media:Media;
	private var __exif:Exif;
	
	// 
	public function Photo(o:Object)
	{
		super(o);
		
		__summary = o.summary;
		__content = new Content(o.content.attributes.type, o.content.attributes.src);
		__published = o.published;
		
		__gphoto = new GPhoto(o, KindType.PHOTO);
		__media = new Media(o["media:group"]);
		__exif = new Exif(o["exif:tags"]);
	}
	
	// 
	public function get summary():String
	{
		return __summary;
	}
	
	// 
	public function set summary(v:String):Void
	{
		__summary = v;
	}

	// 
	public function get content():Content
	{
		return __content;
	}
	
	// 
	public function set content(v:Content):Void
	{
		__content = v;
	}

	// 
	public function get published():String
	{
		return __published;
	}
	
	// 
	public function set published(v:String):Void
	{
		__published = v;
	}
	
	// 
	public function get gphoto():GPhoto
	{
		return __gphoto;
	}
	
	// 
	public function get media():Media
	{
		return __media;
	}
	
	// 
	public function get exif():Exif
	{
		return __exif;
	}
	
}
/*
<entry>
  <id>http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5094406297232552993/photoid/5094406481916146738</id> 
  <published>2007-08-03T09:39:00.000Z</published> 
  <updated>2007-08-03T09:48:37.000Z</updated> 
  <category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#photo" /> 
  <title type="text">20070729_01.jpg</title> 
  <summary type="text">Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</summary> 
  <content type="image/jpeg" src="http://lh6.google.com/thisispinkfu/RrL3tDgPNDI/AAAAAAAAATM/kQtZ_IXJvv0/20070729_01.jpg" /> 
  <link rel="http://schemas.google.com/g/2005#feed" type="application/atom+xml" href="http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5094406297232552993/photoid/5094406481916146738" /> 
  <link rel="alternate" type="text/html" href="http://picasaweb.google.com/thisispinkfu/SampleAlbum/photo#5094406481916146738" /> 
  <link rel="self" type="application/atom+xml" href="http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5094406297232552993/photoid/5094406481916146738" /> 
  <link rel="http://schemas.google.com/photos/2007#report" type="text/html" href="http://picasaweb.google.com/lh/reportAbuse?uname=thisispinkfu&aid=5094406297232552993&iid=5094406481916146738" /> 
  <gphoto:id>5094406481916146738</gphoto:id> 
  <gphoto:version>1186134517936538</gphoto:version> 
  <gphoto:position>0.0</gphoto:position> 
  <gphoto:albumid>5094406297232552993</gphoto:albumid> 
  <gphoto:width>320</gphoto:width> 
  <gphoto:height>240</gphoto:height> 
  <gphoto:size>67633</gphoto:size> 
  <gphoto:client /> 
  <gphoto:checksum /> 
  <gphoto:timestamp>1186133939000</gphoto:timestamp> 
- <exif:tags>
  <exif:flash>true</exif:flash> 
  <exif:imageUniqueID>9edbccc348747b101563e4c587acabe0</exif:imageUniqueID> 
  </exif:tags>
  <gphoto:commentingEnabled>true</gphoto:commentingEnabled> 
  <gphoto:commentCount>0</gphoto:commentCount> 
- <media:group>
  <media:title type="plain">20070729_01.jpg</media:title> 
  <media:description type="plain">Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</media:description> 
  <media:keywords /> 
  <media:thumbnail url="http://lh6.google.com/thisispinkfu/RrL3tDgPNDI/AAAAAAAAATM/kQtZ_IXJvv0/s72/20070729_01.jpg" height="54" width="72" /> 
  <media:thumbnail url="http://lh6.google.com/thisispinkfu/RrL3tDgPNDI/AAAAAAAAATM/kQtZ_IXJvv0/s144/20070729_01.jpg" height="108" width="144" /> 
  <media:thumbnail url="http://lh6.google.com/thisispinkfu/RrL3tDgPNDI/AAAAAAAAATM/kQtZ_IXJvv0/s288/20070729_01.jpg" height="216" width="288" /> 
  <media:content url="http://lh6.google.com/thisispinkfu/RrL3tDgPNDI/AAAAAAAAATM/kQtZ_IXJvv0/20070729_01.jpg" height="240" width="320" type="image/jpeg" medium="image" /> 
  <media:credit>Pink-fu</media:credit> 
  </media:group>
  </entry>
*/