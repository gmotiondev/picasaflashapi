import Picasa.objects.Collection;//import Picasa.objects.Media;
//import Picasa.objects.GPhoto;import Picasa.objects.ObjectList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class Picasa.Album extends Collection
{
	public function Album(a:Object)
	{
		super(a, ObjectList.ALBUM);
	}
	/**
	 * public	 */
	public function getRights():String
	{
		return __d["rights"];
	}
	/**
	 * Pink-fu	 */
	public function getAuthorName():String
	{
		return __d["author"]["name"];
	}
	/**
	 * http://picasaweb.google.com/thisispinkfu	 */
	public function getAuthorUri():String
	{
		return __d["author"]["uri"];
	}
	/**
	 * http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5046158866819398449	 */
	public function getLink():String
	{		return __d["link"][0].attributes.href;
	}
	/**
	 * UnsortedLomo	 */
	public function getAlbumName():String
	{
		return getGPhoto().name;
	}
	/**
	 * Various	 */
	public function getLocation():String
	{
		return getGPhoto().location;
	}
	/**
	 * public	 */
	public function getAccess():String
	{
		return getGPhoto().access;
	}
	/**
	 * 12	 */
	public function getPhotosCount():Number
	{
		return getGPhoto().numphotos;
	}
	/**
	 * !TODO (if logged in only variable?)
	 * 488	 */
	public function getRemainingPhotosCount():Number
	{
		return getGPhoto().numphotosremaining;
	}
	/**
	 * !TODO (if logged in only variable?)
	 * 1203384	 */
	public function getBytesUsed():Number
	{
		return getGPhoto().bytesUsed;
	}
}