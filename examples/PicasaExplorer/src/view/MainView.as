/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import mx.controls.DataGrid;
import mx.controls.Button;
import mx.controls.Tree;

class view.MainView extends MovieClipHelper
{
	private var dg:DataGrid;
	private var tree:Tree;
	
	public function MainView(name:String, mc:MovieClip)
	{
		super(name, mc);
		initialize();
	}
	
	private function initialize():Void
	{
		tree = view.createClassObject(Tree,"tree_mc", 6);
		tree.dataProvider = (new XML("<node><node label=\"My Bookmarks\"><node label=\"Macromedia Web site\" url=\"http://www.macromedia.com\" /><node label=\"MXNA blog aggregator\" url=\"http://www.markme.com/mxna\" /></node><node label=\"Google\" url=\"http://www.google.com\" /></node>")).firstChild;
		tree.setSize(320, 320);
		
		dg = view.createClassObject(DataGrid, "dg_mc", 5, {columnNames:["name", "score"]});
		dg.move(330, 0);
		dg.setSize(320, 320);
		var myDP_array:Array = new Array();
			myDP_array.push({name:"Clark", score:3135});
			myDP_array.push({name:"Bruce", score:403});
			myDP_array.push({name:"Peter", score:25});

		dg.dataProvider = myDP_array;
		trace("> "+dg)
		
		//var bt:Button = view.createClassObject(Button,"button2", 7, {label:"Test Button"});
		//	bt.label = "test!";
		//dg = view.attachMovie("DataGrid","DataGrid",5);
	}
}