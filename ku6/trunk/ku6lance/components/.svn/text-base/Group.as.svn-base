package components
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Group extends Sprite
	{
		public function Group()
		{
			super();
		}
		public function addChildren(...arg):void{
			
			for each(var o:DisplayObject in arg){
				
				this.addChild(o);
				this.dispatchEvent(new Event(Event.RENDER));
				
			}
			
		}
		public function removeAllChildren():void{
			
			while(this.numChildren){
				
				this.removeChildAt(this.numChildren - 1);
				
			}
			
		}
	}
}