package command.photo 
{
	import flash.events.Event;
	
	import com.bourre.commands.AbstractCommand;
	import com.bourre.commands.Command;
	import com.bourre.model.ModelLocator;
	
	import model.ModelApplication;
	import model.ModelList;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class PhotoGetNextCommand extends AbstractCommand implements Command 
	{
		private var __model : ModelApplication;

		override public function execute(evt : Event = null) : void
		{
			__model = ModelApplication(ModelLocator.getInstance().getModel(ModelList.MODEL_APPLICATION));
			__model.next();
		}
	}
}
