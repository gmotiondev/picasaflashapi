package sk.prasa.webapis.picasa.objects 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Media 
	{
		public var content : MediaContent;	// media:content
		public var credit : String; 		// media:credit
		public var description : String; 	// media:description
		public var keywords : Array = []; 	// media:keywords
		public var thumbnail : Array = [];	// media:thumbnail	//Array of MediaThumbnail
		public var title : String;			// media:title
		
		private namespace media = "http://search.yahoo.com/mrss/";
		
		public function Media(item : XML)
		{
			//use namespace media; //(doesn't work like this!)

			try
			{
				content = getMediaContent(item.media::group);
				credit = item.media::group.media::credit;
				description = item.media::group.media::description;
				keywords = getKeywords(item.media::group.media::keywords);
				thumbnail = getThumbnails(item.media::group);
				title = item.media::group.media::title;
				
			} catch(e : Error)
			{
				// e.g. when parsed from photo as parent, album doesn't have media:group
			}
		}
		
		private function getMediaContent(item : XMLList) : MediaContent
		{
			return new MediaContent(item.media::content.@url, item.media::content.@type, item.media::content.@medium, parseFloat(item.media::content.@height), parseFloat(item.media::content.@width), parseFloat(item.media::content.@fileSize));
		}
		
		private function getKeywords(k : String) : Array
		{
			return k.split(" ").join("").split(",");
		}
		
		private function getThumbnails(item : XMLList) : Array
		{
			try
			{
				var tRes : Array = [];
				
				for each(var thumb : XML in item.media::thumbnail)
				{
					tRes.push(new MediaThumbnail(thumb.@url, parseFloat(thumb.@width), parseFloat(thumb.@height))); 
				}
				
				return tRes;
			} catch(e : Error)
			{
				throw new Error(e);
			}
			
			return null;
		}
		
		public function toString() : String
		{
			try
			{
				return "[Media " +
					" content=" + content.toString() + 
					", credit=" + credit + 
					", description=" + description + 
					", keywords=" + keywords.toString() + 
					", thumbnail=" + thumbnail.toString() + 
					", title=" + title + 
					"]";
			} catch(e : Error)
			{
				// e.g. when parsed from photo as parent, album doesn't have media:group
				return "";
			}
			
			return null;
		}
	}
}

/*
	<media:group>
		<media:title type="plain">Diana plus</media:title>
		<media:description type="plain"/>
		<media:keywords/>
		<media:content url="http://lh3.google.com/thisispinkfu/R6DRgaBGIdE/AAAAAAAABR0/WzCg01fEF8k/DianaPlus.jpg" type="image/jpeg" medium="image"/>
		<media:thumbnail url="http://lh3.google.com/thisispinkfu/R6DRgaBGIdE/AAAAAAAABR0/WzCg01fEF8k/s160-c/DianaPlus.jpg" height="160" width="160"/>
		<media:credit>Pink-fu</media:credit>
	</media:group>
*/