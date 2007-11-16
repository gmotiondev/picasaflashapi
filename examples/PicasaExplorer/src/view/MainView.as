/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import mx.controls.DataGrid;
import mx.controls.Button;

class view.MainView extends MovieClipHelper
{
	private var dg:MovieClip;
	
	public function MainView(name:String, mc:MovieClip)
	{
		super(name, mc);
		initialize();
	}
	
	private function initialize():Void
	{
		dg = view.createClassObject(DataGrid, "dg_mc", 5);
		var bt:Button = view.createClassObject(Button,"button2",5,{label:"Test Button"});
			bt.label = "test!";
		//dg = view.attachMovie("DataGrid","DataGrid",5);
	}
}