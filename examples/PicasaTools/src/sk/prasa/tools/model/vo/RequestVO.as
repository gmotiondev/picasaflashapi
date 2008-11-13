package sk.prasa.tools.model.vo 
{

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class RequestVO 
	{
		public var userid : String;// = "thisispinkfu";
		public var albumid : String;// = "5161355527636525521";
		public var tag : String;
		public var thumbsize : String = "64c";
		public var imgmax : String = "576";
		public var start_index : int = 1;
		public var max_results : int = 100;
		
		public function RequestVO(params : Object = null)
		{	
			parseParams(params);
		}
		
		/**
		 * Parses the params out from an object
		 * 
		 * @private
		 */
		private function parseParams(params : Object) : void
		{
			// if params object exists
			if(params != null)
			{
				if(params["userid"] != null) this.userid = params["userid"];
				if(params["albumid"] != null) this.albumid = params["albumid"];
				if(params["tag"] != null) this.tag = params["tag"];
				if(params["thumbsize"] != null) this.thumbsize = params["thumbsize"];
				if(params["imgmax"] != null) this.imgmax = params["imgmax"];
				if(params["start_index"] != null) this.start_index = params["start_index"];
				if(params["max_results"] != null) this.max_results = params["max_results"];
			}
		}
		
		/**
		 * Returns a string representation of the object
		 */
		public function toString() : String
		{
			return "[RequestVO userid=" + this.userid + ", " +
							"albumid=" + this.albumid + ", " +
							"tag=" + this.tag + ", " +
							"thumbsize=" + this.thumbsize + ", " +
							"imgmax=" + this.imgmax + ", " +
							"start_index=" + this.start_index + ", " +
							"max_results=" + this.max_results + "]";
		}
		
		/**
		 * Clones current object
		 */
		public function clone() : RequestVO
		{
			var tRequest : RequestVO = new RequestVO();
				tRequest.userid = this.userid;
				tRequest.albumid = this.albumid;
				tRequest.tag = this.tag;
				tRequest.thumbsize = this.thumbsize;
				tRequest.imgmax = this.imgmax;
				tRequest.start_index = this.start_index;
				tRequest.max_results = this.max_results;
				
			return tRequest;
		}
	}
}
