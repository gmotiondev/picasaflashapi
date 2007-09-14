interface  nbilyk.interfaces.DrawInterface {		
	public function invalidate();
	public function validate();
	public function draw();	
	/*
	private var validator_mc:MovieClip;
	public function draw() {
		this.validate();
	}
	public function invalidate() {
		var root_obj = this;
		if (this.validator_mc == undefined) {
			this.createEmptyMovieClip("validator_mc", this.getNextHighestDepth());
			this.validator_mc.onEnterFrame = function() {
				root_obj.draw();
				this.removeMovieClip();
			}
		}
	}
	public function validate() {
		this.validator_mc.removeMovieClip();
	}
	*/
}