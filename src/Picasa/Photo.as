/**
 * Deprecated, will be deleted
 */
 import Picasa.objects.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class Picasa.Photo extends Collection
{	
	public function Photo(a:Object)
	{
		super(a, ObjectList.PHOTO);
	}

	/**
	 * Returns Picasa Photo url like:
	 * http://lh3.google.com/image/thisispinkfu/RUSARGE-ABI/AAAAAAAAAAk/bC10dIK1qlo/Untitled-3.jpg
	 * @return Picasa Photo url string.	 */
	public function getContent():String
	{
		return __d["content"].attributes.src;
	}
	/**
	 * Same as getContent();
	 * 
	 * Returns Picasa Photo url like:
	 * http://lh3.google.com/image/thisispinkfu/RUSARGE-ABI/AAAAAAAAAAk/bC10dIK1qlo/Untitled-3.jpg
	 * @return Picasa Photo url string.	 */
	public function getLink():String
	{
		return getContent();
	}
	/**
	 * Returns Picasa Album id where the Picasa Photo is stored.
	 * @return Picasa Album id.	 */
	public function getAlbumId():String
	{
		return getGPhoto().albumid;
	}
	/** like:
	 * 1162117188000000
	 * @return 	 */
	public function getVersion():String
	{
		return getGPhoto().version;
	}
	/** 
	 * The ordinal position of the photo within the parent album
	 * 	 * like:
	 * 0.0	 */
	public function getPosition():Object
	{
		var p = (getGPhoto().position).split(".");
		return {x:parseFloat(p[0]), y:parseFloat(p[1])};
	}
	/**
	 * 1024	 */
	public function getWidth():Number
	{
		return parseFloat(getMedia().content.width);
	}
	/**
	 * 713	 */
	public function getHeight():Number
	{
		return parseFloat(getMedia().content.height);
	}
	/**
	 * 77271	 */
	public function getSize():Number
	{
		return parseFloat(getGPhoto().size);
	}
	/**
	 * 	 */
	public function getThumbWidth():Number
	{
		return parseFloat(getMedia().thumbnail.width);
	}
	public function getThumbHeight():Number
	{
		return parseFloat(getMedia().thumbnail.height);
	}
	/**
	 * Picasa2.6	 */
	public function getClient():String
	{
		return getGPhoto().client;
	}
	/**
	 * 572b6066	 */
	public function getChecksum():String
	{
		return getGPhoto().checksum;
	}
	/**
	 * 1162117188000
	 */
	public function getTimestamp():Number
	{
		return __g.timestamp;
	}
}