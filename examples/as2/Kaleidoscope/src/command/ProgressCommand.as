﻿/**
 * @author michal.gron@gmail.com
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.ProgressEvent;

class command.ProgressCommand implements Command
{
	private var model:ModelApplication; 
	
	public function execute(evt:ProgressEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.notifyChanged(evt);
	}
}