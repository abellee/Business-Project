package view {
	import factory.ButtonFactory;

	import fl.controls.Button;

	import com.kge.containers.VGroup;
	import com.kge.core.UIView;
	import com.kge.delegates.IUIView;

	/**
	 * @author Abel
	 */
	public class SearchAndPages extends UIView implements IUIView {
		private var searchButton : Button;
		private var flipUpButton : Button;
		private var flipDownButton : Button;
		private var pagesList : VGroup;
		private var pageNumber : int;
		private var pagesButtons : Vector.<Button> = new Vector.<Button>();
		private var container : VGroup = new VGroup();

		public function SearchAndPages(searchable : Boolean = true) {
			if (searchable)
				searchButton = ButtonFactory.SearchButton();
		}

		public function initPagesList(pages : int) : void {
			pageNumber = pages;
			if (!pagesList) pagesList = new VGroup();
			pagesList.delegate = this;
			for (var i : int = 0; i < pages; i++) {
				var btn : Button = ButtonFactory.PageButton();
				btn.label = i + "";
				pagesButtons.push(btn);
				pagesList.addChild(pagesList);
			}
			addChild(pagesList);
			if (pages > 4) {
				flipUpButton = ButtonFactory.PageButton();
				flipDownButton = ButtonFactory.PageButton();
			}
		}

		public function changingFinished(view : UIView) : void {
			if (searchButton)
				container.addChild(searchButton);
			if (flipUpButton)
				container.addChild(flipUpButton);
			container.addChild(view);
			if(flipDownButton)
				container.addChild(flipDownButton);
		}
	}
}
