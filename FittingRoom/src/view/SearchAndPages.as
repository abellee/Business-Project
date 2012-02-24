package view {
	import com.kge.containers.VGroup;
	import com.kge.core.UIView;
	import com.kge.delegates.IUIView;
	
	import factory.ButtonFactory;
	
	import fl.controls.Button;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	import global.Global;

	/**
	 * @author Abel
	 */
	public class SearchAndPages extends UIView {
		private var searchButton : UIButton;
		private var flipUpButton : Button;
		private var flipDownButton : Button;
		private var pagesList : VGroup;
		private var pageNumber : int;
		private var pagesButtons : Vector.<Button> = new Vector.<Button>();
		private var container : VGroup = new VGroup();
		private var background : Bitmap;

		public function SearchAndPages(dir : String, searchable : Boolean = true) {
			background = new Bitmap(Global.staticAssets.barSkin());
			addChild(background);
			if (dir == "left") {
				background.scaleX = -1;
				background.x = background.width;
			}

			if (searchable) {
				searchButton = ButtonFactory.SearchButton(dir);
				addChild(searchButton);
				searchButton.addEventListener(MouseEvent.CLICK, onSearchButtonClick);
			}
			
			initPagesList(6);
		}
		
		protected function onSearchButtonClick(event:MouseEvent):void
		{
			FittingRoom.instance.showSearchPanel(this.parent as FloatPanel);
		}
		
		public function initPagesList(pages : int) : void {
			pageNumber = pages;
			if (!pagesList) pagesList = new VGroup();
			pagesList.gap = 0;
			pages = pages > 4 ? 4 : pages;
			for (var i : int = 0; i < pages; i++) {
				var btn : Button = ButtonFactory.PageButton();
				btn.label = (i + 1) + "";
				btn.setStyle("textFormat", new TextFormat("宋体", 12, 0xFFFFFF));
				pagesButtons.push(btn);
				pagesList.addChild(btn);
			}
			addChild(pagesList);
			pagesList.y = 76;
			if (pageNumber > 4) {
				flipUpButton = ButtonFactory.FlipUpButton();
				flipDownButton = ButtonFactory.FlipDownButton();
				addChild(flipUpButton);
				addChild(flipDownButton);
				flipUpButton.y = 53;
				flipDownButton.y = background.height - flipDownButton.height;
			}
		}
	}
}
