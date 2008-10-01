import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;

import business.*;
import control.LoadFeedEvent;
import control.thumb.LoadThumbsEvent;
import model.*;

import sk.prasa.mvc.command.IResponder;
import sk.prasa.webapis.picasa.Photo;
import sk.prasa.webapis.picasa.PicasaError;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class command.LoadFeedCommand implements Command, IResponder
{
	private var model : ModelApplication; 

	public function execute(evt : LoadFeedEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.service.max_results = calculateMaxResults(model.service.thumbsize);
		
		var tQuery : String = evt.query;
		var d : LoadFeedDelegate = new LoadFeedDelegate(this);
			d.search(tQuery);
	}

	private function calculateMaxResults(aThumbsize : Number) : Number
	{
		return Math.floor(( Stage.width + (aThumbsize / 2)) / aThumbsize) * Math.floor((Stage.height + (aThumbsize / 2)) / aThumbsize);
	}	
	
	public function result(data : Array) : Void
	{
		var tTotalResults : Number = (data.length != 0) ? data[0].parent.opensearch.totalResults : 0;
		var tStartIndex : Number = (data.length != 0) ? data[0].parent.opensearch.startIndex : 0;
		var tItemsPerPage : Number = (data.length != 0) ? data[0].parent.opensearch.itemsPerPage : 0;

		model.photos.init();

		for(var a : Number = 0;a < data.length; a++)
		{
			var tPhoto : Photo = data[a];
			model.photos.push(tPhoto);
		}

		EventBroadcaster.getInstance().broadcastEvent(new LoadThumbsEvent(tTotalResults, tStartIndex, tItemsPerPage));
	}

	public function fault(error : PicasaError) : Void
	{
		trace("GetPhotosCommand failed: " + error.message);
	}
}