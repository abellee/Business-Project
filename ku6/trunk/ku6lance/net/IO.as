package net
{
	import events.IOEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	public class IO extends EventDispatcher
	{
		
		private var loader:URLLoader = new URLLoader();
		
		private var path:URLRequest = new URLRequest("http://hd.ku6.com/ppdata.html");
		
		private var xmlLoader:URLLoader = new URLLoader();
		private var xmlPath:URLRequest = new URLRequest("http://hd.ku6.com/static/p2p.xml");
		
		private var searchLoader:URLLoader = new URLLoader();
		private var searchPath:URLRequest = new URLRequest("http://so.juchang.com/jc");
		
		public function IO(target:IEventDispatcher=null)
		{
			super(target);
		}
		public function getData(urlVar:URLVariables):void{
			
			path.data = urlVar;
			loader.addEventListener(Event.COMPLETE, dataLoad_completeHandler);
			loader.load(path);
			
		}
		private function dataLoad_completeHandler(event:Event):void{
			
			loader.removeEventListener(Event.COMPLETE, dataLoad_completeHandler);
			var ioevent:IOEvent = new IOEvent(IOEvent.DATA_LOAD_COMPLETE);
			ioevent.result = {};
			ioevent.result = event.target.data;
			this.dispatchEvent(ioevent);
			
		}
		public function getCateXML():void{
			
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			xmlLoader.load(xmlPath);
			
		}
		private function xmlLoaded(event:Event):void{
			
			xmlLoader.removeEventListener(Event.COMPLETE, xmlLoaded);
			var xml:XML = XML(xmlLoader.data);
			xmlLoader = null;
			xmlPath = null;
			
			var xmlEvent:IOEvent = new IOEvent(IOEvent.XML_LOAD_COMPLETE);
			xmlEvent.result = xml;
			this.dispatchEvent(xmlEvent);
			
		}
		public function getSearchResult(urlVar:URLVariables):void{
			
			urlVar.from = "zz";
			urlVar.channel = 4;
			searchPath.data = urlVar;
			searchLoader.addEventListener(Event.COMPLETE, searchResult_completeHandler);
			searchLoader.load(searchPath);
			
		}
		private function searchResult_completeHandler(event:Event):void{
			
			searchLoader.removeEventListener(Event.COMPLETE, searchResult_completeHandler);
			var obj:Object = searchLoader.data;
			
			var searchEvent:IOEvent = new IOEvent(IOEvent.SEARCH_RESULT);
			searchEvent.result = obj;
			this.dispatchEvent(searchEvent);
			
		}
	}
}