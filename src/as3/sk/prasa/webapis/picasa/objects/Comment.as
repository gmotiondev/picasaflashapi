package sk.prasa.webapis.picasa.objects 
{	import sk.prasa.webapis.picasa.objects.BasicEntry;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Comment extends BasicEntry
	{
		public var gphoto : GPhoto;
		//BUG?: GPHOTO IS IN THE AUTHOR FEED
		
		default xml namespace = "http://www.w3.org/2005/Atom";
		
		public function Comment(aItem : XML, aParent : XML = null)
		{
			super(aItem, aParent);
			
			gphoto = new GPhoto(aItem, KindType.COMMENT);
		}
		
		override public function toString() : String
		{
			return "[Comment" + super.toString() +
				", gphoto=" + gphoto.toString() +
				"]";
		} 
	}
}

/*
<entry>
	<id>http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5150986992011782785/photoid/5163225994483868290/commentid/5164365741365273300</id>
	<published>2008-02-07T22:16:39.000Z</published>
	<updated>2008-02-07T22:16:39.000Z</updated>
	<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#comment"/>
	<title type="text">Pink-fu</title>
	<content type="text">eh.. co ti ja viem.. :)</content>
	<link rel="alternate" type="text/html" href="http://picasaweb.google.com/lh/photo/fMjcPGqu8ttEsQOOiaExfw"/>
	<link rel="self" type="application/atom+xml" href="http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5150986992011782785/photoid/5163225994483868290/commentid/5164365741365273300"/>
	<link rel="edit" type="application/atom+xml" href="http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5150986992011782785/photoid/5163225994483868290/commentid/5164365741365273300?tok=HQGO0PHayM2if4ObETtJWmgFp6w"/>
	<author>
		<name>Pink-fu</name>
		<uri>http://picasaweb.google.com/thisispinkfu</uri>
		<gphoto:user>thisispinkfu</gphoto:user>
		<gphoto:nickname>Pink-fu</gphoto:nickname>
		<gphoto:thumbnail>http://lh6.google.com/thisispinkfu/AAAAY-cVBS8/AAAAAAAAAAA/CRZkCWt3d5Y/s48-c/thisispinkfu.jpg</gphoto:thumbnail>
	</author>
	<gphoto:id>5164365741365273300</gphoto:id>
	<gphoto:albumid>0</gphoto:albumid>
	<gphoto:photoid>5163225994483868290</gphoto:photoid>
</entry>

*/