package components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class HGroup extends Group
	{
		
		private var _dataProvider:Array;
		
		private var _hGap:uint = 5;
		private var _vGap:uint = 5;
		
		private var _column:uint = 1;
		private var _row:uint = 1;
		
		public function HGroup()
		{
			super();
		}
		override public function addChildren(...arg):void{
			
			for each(var o:DisplayObject in arg){
				
				this.addChild(o);
				this.dispatchEvent(new Event(Event.RENDER));
				
			}
			updateList();
			
		}
		private function updateList():void{
			
			var num:uint = this.numChildren;
			for(var i:uint = 0; i < num; i++){
				
				var o:DisplayObject = this.getChildAt(i) as DisplayObject;
				o.x = (i % _column) * (_hGap + o.width);
				o.y = uint(i / _column) * (_vGap + o.height);
				
			}
			
		}
		
		public function set hGap(gap:uint):void{
			
			_hGap = gap;
			
		}
		
		public function get hGap():uint{
			
			return _hGap;
			
		}
		
		public function set vGap(gap:uint):void{
			
			_vGap = gap;
			
		}
		
		public function get vGap():uint{
			
			return _vGap;
			
		}
		
		public function set row(value:uint):void{
			
			_row = value;
			
		}
		
		public function get row():uint{
			
			return _row;
			
		}
		
		public function set column(value:uint):void{
			
			_column = value;
			
		}
		
		public function get column():uint{
			
			return _column;
			
		}
		
		public function set dataProvider(arr:Array):void{
			
			if(!arr || !arr.length){
				
				return;
				
			}
			if(this.numChildren){
				
				this.removeAllChildren();
				
			}
			_dataProvider = arr;
			addChildren(arr);
			
		}
		
		public function get dataProvider():Array{
			
			return _dataProvider;
			
		}
		
	}
}