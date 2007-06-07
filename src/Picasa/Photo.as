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
	 * Returns a Photo thumbnails link object (s,m,l size) with urls.
	 * @return Photo thumbnails link object.	 */
	public function getThumbnailsLinks():Object{
		return {
			s : getMedia().thumbnail_s,
			m : getMedia().thumbnail_m,
			l : getMedia().thumbnail_l
		}
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
	public function getPosition():Number
	{
		return getGPhoto().position;
	}
	/**
	 * 1024	 */
	public function getWidth():Number
	{
		return getGPhoto().width;
	}
	/**
	 * 713	 */
	public function getHeight():Number
	{
		return getGPhoto().height;
	}
	/**
	 * 77271	 */
	public function getSize():Number
	{
		return getGPhoto().size;
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