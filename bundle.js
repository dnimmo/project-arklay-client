/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _inventory = __webpack_require__(1);

	var _room = __webpack_require__(4);

	var _roomManager = __webpack_require__(5);

	var _inventoryManager = __webpack_require__(8);

	__webpack_require__(9);


	document.addEventListener('data-updated-inventory', _inventoryManager.updateInventoryUI);
	document.addEventListener('data-updated-room', _roomManager.updateRoomUI);

	// Start game
	(0, _inventory.initialiseInventory)();
	(0, _room.getRoom)('start');

/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _require = __webpack_require__(2);

	var request = _require.request;

	var _require2 = __webpack_require__(3);

	var getData = _require2.getData;


	var initialiseInventory = function initialiseInventory() {
	  return request('GET', 'http://api.project-arklay.com/inventory/initialise', '', 'inventory');
	};

	var addItem = function addItem(itemName) {
	  return request('PATCH', 'http://api.project-arklay.com/inventory/add/' + itemName, getData('inventory'), 'inventory');
	};

	module.exports = {
	  initialiseInventory: initialiseInventory,
	  addItem: addItem
	};

/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _require = __webpack_require__(3);

	var updateData = _require.updateData;


	var request = function request(type, url, body, dataType) {
	  // 'dataType' refers to either 'inventory' or 'room'
	  function listener() {
	    requester.removeEventListener('load', listener);
	    updateData(dataType, this.responseText);
	  }

	  var requester = new XMLHttpRequest();
	  requester.addEventListener('load', listener);
	  requester.open(type, url);
	  requester.setRequestHeader('content-type', 'application/json');
	  requester.send(JSON.stringify(body));
	};

	module.exports = {
	  request: request
	};

/***/ },
/* 3 */
/***/ function(module, exports) {

	'use strict';

	var dataStore = {
	  inventory: {},
	  room: {}
	};

	var dataUpdated = {
	  inventory: new Event('data-updated-inventory'),
	  room: new Event('data-updated-room')
	};
	var emitUpdateEvent = function emitUpdateEvent(type) {
	  return document.dispatchEvent(dataUpdated[type]);
	};

	var getData = function getData(type) {
	  return dataStore[type];
	};

	var updateData = function updateData(type, data) {
	  // Update data, and emit event if updated data is different from pre-update data
	  dataStore[type] = JSON.parse(data);
	  emitUpdateEvent(type);
	};

	module.exports = {
	  getData: getData,
	  updateData: updateData
	};

/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _require = __webpack_require__(2);

	var request = _require.request;

	var _require2 = __webpack_require__(3);

	var getData = _require2.getData;


	var getRoom = function getRoom(slug) {
	  return request('POST', 'http://localhost:8081/rooms/' + slug, getData('inventory'), 'room');
	};

	module.exports = {
	  getRoom: getRoom
	};

/***/ },
/* 5 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _elements = __webpack_require__(6);

	var _commonFunctions = __webpack_require__(7);

	var _room = __webpack_require__(4);

	var _store = __webpack_require__(3);

	// Elements that need to be updated
	function addButton(_ref) {
	  var displayText = _ref.displayText;
	  var rel = _ref.rel;
	  var link = _ref.link;

	  var button = document.createElement("li");
	  (0, _commonFunctions.addClass)(button, rel);
	  // If 'displayText' exists on direction, use that instead of rel
	  (0, _commonFunctions.updateText)(button, displayText || rel);
	  _elements.directions.appendChild(button);
	  button.addEventListener('click', listener);

	  function listener() {
	    // destroy 'directions' document
	    return (0, _room.getRoom)(link);
	  }
	}

	var updateRoomUI = function updateRoomUI() {
	  (0, _commonFunctions.clearContents)(_elements.directions);
	  var roomInfo = (0, _store.getData)('room');
	  (0, _commonFunctions.updateText)(_elements.roomDescription, roomInfo.description);
	  (0, _commonFunctions.updateText)(_elements.roomDetails, roomInfo.surroundings);

	  if (!roomInfo.directions) {
	    return;
	  }

	  // Set up each direction in the UI
	  roomInfo.directions.forEach(function (direction) {
	    return addButton(direction);
	  });
	};

	module.exports = {
	  updateRoomUI: updateRoomUI
	};

/***/ },
/* 6 */
/***/ function(module, exports) {

	'use strict';

	Object.defineProperty(exports, "__esModule", {
	  value: true
	});
	var getElement = exports.getElement = function getElement(id) {
	  return document.getElementById(id);
	};

	// Room
	var roomDescription = exports.roomDescription = getElement('roomDescription');
	var roomDetails = exports.roomDetails = getElement('roomDetails');
	var directions = exports.directions = getElement('directions');

	// Inventory
	var inventoryToggle = exports.inventoryToggle = getElement('inventoryToggle');
	var inventory = exports.inventory = getElement('inventory');
	var closeInventory = exports.closeInventory = getElement('closeInventory');

/***/ },
/* 7 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	Object.defineProperty(exports, "__esModule", {
	  value: true
	});
	exports.clearContents = exports.toggleClass = exports.removeClass = exports.addClass = exports.updateText = undefined;

	var _elements = __webpack_require__(6);

	var updateText = exports.updateText = function updateText(element, update) {
	  return element.innerText = update;
	};
	var addClass = exports.addClass = function addClass(element, classToAdd) {
	  return element.classList.add(classToAdd);
	};
	var removeClass = exports.removeClass = function removeClass(element, classToRemove) {
	  return element.classList.remove(classToRemove);
	};
	var toggleClass = exports.toggleClass = function toggleClass(element, classToToggle) {
	  return element.classList.toggle(classToToggle);
	};
	var clearContents = exports.clearContents = function clearContents(element) {
	  return element.innerHTML = '';
	};

/***/ },
/* 8 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _elements = __webpack_require__(6);

	var _commonFunctions = __webpack_require__(7);

	var _store = __webpack_require__(3);

	var _inventory = __webpack_require__(1);

	// Elements that need to be updated
	var toggleInventory = function toggleInventory() {
	  return (0, _commonFunctions.toggleClass)(_elements.inventory, 'hidden');
	};

	_elements.inventoryToggle.addEventListener('click', toggleInventory);
	_elements.closeInventory.addEventListener('click', toggleInventory);

	var updateInventoryUI = function updateInventoryUI() {

	  if (_elements.inventory['items'] && _elements.inventory.items.length > 0) {
	    (0, _commonFunctions.removeClass)(_elements.inventoryToggle, 'hidden');
	  } else {
	    (0, _commonFunctions.addClass)(_elements.inventoryToggle, 'hidden');
	  }
	};

	module.exports = {
	  updateInventoryUI: updateInventoryUI
	};

/***/ },
/* 9 */
/***/ function(module, exports, __webpack_require__) {

	// style-loader: Adds some css to the DOM by adding a <style> tag

	// load the styles
	var content = __webpack_require__(10);
	if(typeof content === 'string') content = [[module.id, content, '']];
	// add the styles to the DOM
	var update = __webpack_require__(12)(content, {});
	if(content.locals) module.exports = content.locals;
	// Hot Module Replacement
	if(false) {
		// When the styles change, update the <style> tags
		if(!content.locals) {
			module.hot.accept("!!./../node_modules/css-loader/index.js!./../node_modules/sass-loader/index.js!./main.scss", function() {
				var newContent = require("!!./../node_modules/css-loader/index.js!./../node_modules/sass-loader/index.js!./main.scss");
				if(typeof newContent === 'string') newContent = [[module.id, newContent, '']];
				update(newContent);
			});
		}
		// When the module is disposed, remove the <style> tags
		module.hot.dispose(function() { update(); });
	}

/***/ },
/* 10 */
/***/ function(module, exports, __webpack_require__) {

	exports = module.exports = __webpack_require__(11)();
	// imports


	// module
	exports.push([module.id, "@-webkit-keyframes fadeIn {\n  0% {\n    opacity: .25; }\n  100% {\n    opacity: 1; } }\n\n@-moz-keyframes fadeIn {\n  0% {\n    opacity: .25; }\n  100% {\n    opacity: 1; } }\n\n@-o-keyframes fadeIn {\n  0% {\n    opacity: .25; }\n  100% {\n    opacity: 1; } }\n\n@keyframes fadeIn {\n  0% {\n    opacity: .25; }\n  100% {\n    opacity: 1; } }\n\n@-webkit-keyframes fadeOut {\n  0% {\n    opacity: 1; }\n  100% {\n    opacity: 0; } }\n\n@-moz-keyframes fadeOut {\n  0% {\n    opacity: 1; }\n  100% {\n    opacity: 0; } }\n\n@-o-keyframes fadeOut {\n  0% {\n    opacity: 1; }\n  100% {\n    opacity: 0; } }\n\n@keyframes fadeOut {\n  0% {\n    opacity: 1; }\n  100% {\n    opacity: 0; } }\n\n@-webkit-keyframes slideIn {\n  0% {\n    transform: translateX(100vw); }\n  100% {\n    transform: translateX(0); } }\n\n@-moz-keyframes slideIn {\n  0% {\n    transform: translateX(100vw); }\n  100% {\n    transform: translateX(0); } }\n\n@-o-keyframes slideIn {\n  0% {\n    transform: translateX(100vw); }\n  100% {\n    transform: translateX(0); } }\n\n@keyframes slideIn {\n  0% {\n    transform: translateX(100vw); }\n  100% {\n    transform: translateX(0); } }\n\n@-webkit-keyframes slideOut {\n  0% {\n    transform: translateX(0); }\n  100% {\n    transform: translateX(100vw); } }\n\n@-moz-keyframes slideOut {\n  0% {\n    transform: translateX(0); }\n  100% {\n    transform: translateX(100vw); } }\n\n@-o-keyframes slideOut {\n  0% {\n    transform: translateX(0); }\n  100% {\n    transform: translateX(100vw); } }\n\n@keyframes slideOut {\n  0% {\n    transform: translateX(0); }\n  100% {\n    transform: translateX(100vw); } }\n\n* {\n  box-sizing: border-box;\n  margin: 0;\n  padding: 0; }\n\nhtml {\n  font-size: 62.5%; }\n\nbody {\n  background-color: #000;\n  color: #fff;\n  font-family: 'PT Serif', serif;\n  font-size: 2rem;\n  line-height: 3.5rem;\n  transition: all linear 0.3s; }\n  @media (min-width: 1000px) {\n    body {\n      font-size: 3rem;\n      line-height: 4.5rem; } }\n\nmain {\n  -webkit-animation: fadeIn 0.5s;\n  -moz-animation: fadeIn 0.5s;\n  -o-animation: fadeIn 0.5s;\n  animation: fadeIn 0.5s;\n  margin-top: 6rem;\n  overflow: hidden;\n  padding-left: 2rem;\n  padding-right: 2rem;\n  text-align: center; }\n  @media (min-width: 700px) {\n    main {\n      margin-top: 8rem;\n      padding: 5%; } }\n  main:focus {\n    outline-color: #000; }\n\nh1 {\n  font-size: 4rem;\n  margin: 2rem 0; }\n\nh2 {\n  margin: 2rem 0; }\n\n.button {\n  border: 0.1rem solid #fff;\n  color: #fff;\n  display: inline-block;\n  font-size: .7em;\n  letter-spacing: .07em;\n  margin: 2rem;\n  min-width: 8rem;\n  padding: .3rem 1rem;\n  text-decoration: none;\n  transition: all linear 0.3s; }\n  .button:hover {\n    background-color: #fff;\n    color: #000;\n    cursor: pointer;\n    transform: scale(1.1); }\n\n.emphasis {\n  font-weight: bold; }\n\n.extra-message {\n  -webkit-animation: fadeIn 0.5s;\n  -moz-animation: fadeIn 0.5s;\n  -o-animation: fadeIn 0.5s;\n  animation: fadeIn 0.5s; }\n\nlabel {\n  margin: 1rem 0; }\n\ninput {\n  background-color: #000;\n  border-width: 0 0 .1rem;\n  color: #fff;\n  font-size: 2rem;\n  margin-bottom: 5rem;\n  text-align: center; }\n\n.direction-options {\n  border-top: 0.2rem solid #fff;\n  list-style: none;\n  margin: 5rem 0 0;\n  padding-top: 2rem; }\n  .direction-options li {\n    border: 0.2rem solid #000;\n    cursor: pointer;\n    font-size: 2rem;\n    height: 6rem;\n    margin: 1rem auto;\n    min-width: 12rem;\n    padding: 1rem;\n    text-transform: capitalize;\n    transition: all linear 0.3s; }\n    .direction-options li:hover {\n      font-weight: bolder;\n      transform: scale(1.3); }\n  .direction-options .east,\n  .direction-options .west {\n    display: inline-block; }\n  .direction-options .west {\n    margin-right: 12rem; }\n    .direction-options .west + .east {\n      margin-left: -12rem; }\n  .direction-options .north + .east {\n    margin-left: 12rem; }\n  .direction-options .north + .south {\n    margin-top: 8rem; }\n\n.hidden {\n  display: none; }\n\n@-webkit-keyframes roll-credits {\n  0% {\n    transform: translate3d(0, 60vh, 0); }\n  100% {\n    transform: translate3d(0, -100vh, 0); } }\n\n@-moz-keyframes roll-credits {\n  0% {\n    transform: translate3d(0, 60vh, 0); }\n  100% {\n    transform: translate3d(0, -100vh, 0); } }\n\n@-o-keyframes roll-credits {\n  0% {\n    transform: translate3d(0, 60vh, 0); }\n  100% {\n    transform: translate3d(0, -100vh, 0); } }\n\n@keyframes roll-credits {\n  0% {\n    transform: translate3d(0, 60vh, 0); }\n  100% {\n    transform: translate3d(0, -100vh, 0); } }\n\n.credits-container {\n  height: 80vh;\n  overflow: hidden;\n  padding: 5vw; }\n  .credits-container .credits {\n    -webkit-animation: roll-credits 20s linear;\n    -moz-animation: roll-credits 20s linear;\n    -o-animation: roll-credits 20s linear;\n    animation: roll-credits 20s linear;\n    margin: auto;\n    text-align: center;\n    transform: translate3d(0, -10000000rem, 0); }\n    .credits-container .credits li {\n      list-style: none;\n      margin-bottom: 4rem; }\n\n.inventory-icon {\n  -webkit-animation: fadeIn 0.5s;\n  -moz-animation: fadeIn 0.5s;\n  -o-animation: fadeIn 0.5s;\n  animation: fadeIn 0.5s;\n  right: 1rem;\n  transition: all linear 0.3s; }\n  @media (min-width: 700px) {\n    .inventory-icon {\n      right: .5rem; } }\n  @media (min-width: 1000px) {\n    .inventory-icon {\n      margin-right: 1rem; } }\n  .inventory-icon:hover {\n    transform: scale(1.2); }\n\n.inventory-count {\n  -webkit-animation: fadeIn 0.5s;\n  -moz-animation: fadeIn 0.5s;\n  -o-animation: fadeIn 0.5s;\n  animation: fadeIn 0.5s;\n  border-radius: .5rem;\n  color: #000;\n  cursor: pointer;\n  display: inline-block;\n  font-size: 1.6rem;\n  font-weight: bold;\n  padding: .2rem .8rem 0;\n  pointer-events: none;\n  position: fixed;\n  right: 2.1rem;\n  top: 2.8rem; }\n  @media (min-width: 700px) {\n    .inventory-count {\n      font-size: 1.8rem;\n      right: 2.1rem;\n      top: 3.3rem; } }\n  @media (min-width: 1000px) {\n    .inventory-count {\n      font-size: 2.5rem;\n      right: 3.7rem;\n      top: 5.3rem; } }\n\n.inventory {\n  border-left: 0.1rem solid #fff;\n  right: 0;\n  width: 90%; }\n  @media (min-width: 700px) {\n    .inventory {\n      width: 45%; }\n      .inventory p {\n        color: #fff; } }\n  .inventory .inventory-contents {\n    -webkit-animation: fadeIn 0.5s;\n    -moz-animation: fadeIn 0.5s;\n    -o-animation: fadeIn 0.5s;\n    animation: fadeIn 0.5s;\n    padding: 2rem 2rem 0; }\n  .inventory .item-options {\n    border-bottom: 0; }\n  .inventory .inventory-toggle {\n    color: #fff;\n    cursor: pointer;\n    display: block;\n    font-size: 2.2rem;\n    margin: 0;\n    transition: all linear 0.3s; }\n  .inventory li.inv {\n    border: 0; }\n  .inventory li .item {\n    height: 7rem;\n    transition: all linear 0.3s;\n    width: 7rem; }\n  .inventory li p {\n    transition: all linear 0.3s; }\n  .inventory li:hover, .inventory li.selected {\n    background-color: #fff;\n    border-radius: .1rem;\n    color: #323232;\n    transform: scale(1.1); }\n    .inventory li:hover svg, .inventory li.selected svg {\n      background-color: #323232;\n      border-radius: 50rem; }\n    .inventory li:hover p, .inventory li.selected p {\n      color: #323232; }\n\n.inventory-icon {\n  background-color: #000;\n  border-radius: 5rem;\n  cursor: pointer;\n  height: 7rem;\n  position: fixed;\n  top: 0;\n  width: 5rem; }\n  @media (min-width: 700px) {\n    .inventory-icon {\n      height: 8rem;\n      position: fixed;\n      top: 0;\n      width: 6rem; } }\n  @media (min-width: 1000px) {\n    .inventory-icon {\n      height: 10rem;\n      margin-top: 1rem;\n      width: 8rem; } }\n\n.inventory {\n  -webkit-animation: slideIn 0.2s;\n  -moz-animation: slideIn 0.2s;\n  -o-animation: slideIn 0.2s;\n  animation: slideIn 0.2s;\n  background-color: #323232;\n  min-height: 100vh;\n  position: fixed;\n  right: 0;\n  text-align: center;\n  top: 0;\n  z-index: 1340; }\n", ""]);

	// exports


/***/ },
/* 11 */
/***/ function(module, exports) {

	"use strict";

	/*
		MIT License http://www.opensource.org/licenses/mit-license.php
		Author Tobias Koppers @sokra
	*/
	// css base code, injected by the css-loader
	module.exports = function () {
		var list = [];

		// return the list of modules as css string
		list.toString = function toString() {
			var result = [];
			for (var i = 0; i < this.length; i++) {
				var item = this[i];
				if (item[2]) {
					result.push("@media " + item[2] + "{" + item[1] + "}");
				} else {
					result.push(item[1]);
				}
			}
			return result.join("");
		};

		// import a list of modules into the list
		list.i = function (modules, mediaQuery) {
			if (typeof modules === "string") modules = [[null, modules, ""]];
			var alreadyImportedModules = {};
			for (var i = 0; i < this.length; i++) {
				var id = this[i][0];
				if (typeof id === "number") alreadyImportedModules[id] = true;
			}
			for (i = 0; i < modules.length; i++) {
				var item = modules[i];
				// skip already imported module
				// this implementation is not 100% perfect for weird media query combinations
				//  when a module is imported multiple times with different media queries.
				//  I hope this will never occur (Hey this way we have smaller bundles)
				if (typeof item[0] !== "number" || !alreadyImportedModules[item[0]]) {
					if (mediaQuery && !item[2]) {
						item[2] = mediaQuery;
					} else if (mediaQuery) {
						item[2] = "(" + item[2] + ") and (" + mediaQuery + ")";
					}
					list.push(item);
				}
			}
		};
		return list;
	};

/***/ },
/* 12 */
/***/ function(module, exports, __webpack_require__) {

	/*
		MIT License http://www.opensource.org/licenses/mit-license.php
		Author Tobias Koppers @sokra
	*/
	var stylesInDom = {},
		memoize = function(fn) {
			var memo;
			return function () {
				if (typeof memo === "undefined") memo = fn.apply(this, arguments);
				return memo;
			};
		},
		isOldIE = memoize(function() {
			return /msie [6-9]\b/.test(window.navigator.userAgent.toLowerCase());
		}),
		getHeadElement = memoize(function () {
			return document.head || document.getElementsByTagName("head")[0];
		}),
		singletonElement = null,
		singletonCounter = 0,
		styleElementsInsertedAtTop = [];

	module.exports = function(list, options) {
		if(false) {
			if(typeof document !== "object") throw new Error("The style-loader cannot be used in a non-browser environment");
		}

		options = options || {};
		// Force single-tag solution on IE6-9, which has a hard limit on the # of <style>
		// tags it will allow on a page
		if (typeof options.singleton === "undefined") options.singleton = isOldIE();

		// By default, add <style> tags to the bottom of <head>.
		if (typeof options.insertAt === "undefined") options.insertAt = "bottom";

		var styles = listToStyles(list);
		addStylesToDom(styles, options);

		return function update(newList) {
			var mayRemove = [];
			for(var i = 0; i < styles.length; i++) {
				var item = styles[i];
				var domStyle = stylesInDom[item.id];
				domStyle.refs--;
				mayRemove.push(domStyle);
			}
			if(newList) {
				var newStyles = listToStyles(newList);
				addStylesToDom(newStyles, options);
			}
			for(var i = 0; i < mayRemove.length; i++) {
				var domStyle = mayRemove[i];
				if(domStyle.refs === 0) {
					for(var j = 0; j < domStyle.parts.length; j++)
						domStyle.parts[j]();
					delete stylesInDom[domStyle.id];
				}
			}
		};
	}

	function addStylesToDom(styles, options) {
		for(var i = 0; i < styles.length; i++) {
			var item = styles[i];
			var domStyle = stylesInDom[item.id];
			if(domStyle) {
				domStyle.refs++;
				for(var j = 0; j < domStyle.parts.length; j++) {
					domStyle.parts[j](item.parts[j]);
				}
				for(; j < item.parts.length; j++) {
					domStyle.parts.push(addStyle(item.parts[j], options));
				}
			} else {
				var parts = [];
				for(var j = 0; j < item.parts.length; j++) {
					parts.push(addStyle(item.parts[j], options));
				}
				stylesInDom[item.id] = {id: item.id, refs: 1, parts: parts};
			}
		}
	}

	function listToStyles(list) {
		var styles = [];
		var newStyles = {};
		for(var i = 0; i < list.length; i++) {
			var item = list[i];
			var id = item[0];
			var css = item[1];
			var media = item[2];
			var sourceMap = item[3];
			var part = {css: css, media: media, sourceMap: sourceMap};
			if(!newStyles[id])
				styles.push(newStyles[id] = {id: id, parts: [part]});
			else
				newStyles[id].parts.push(part);
		}
		return styles;
	}

	function insertStyleElement(options, styleElement) {
		var head = getHeadElement();
		var lastStyleElementInsertedAtTop = styleElementsInsertedAtTop[styleElementsInsertedAtTop.length - 1];
		if (options.insertAt === "top") {
			if(!lastStyleElementInsertedAtTop) {
				head.insertBefore(styleElement, head.firstChild);
			} else if(lastStyleElementInsertedAtTop.nextSibling) {
				head.insertBefore(styleElement, lastStyleElementInsertedAtTop.nextSibling);
			} else {
				head.appendChild(styleElement);
			}
			styleElementsInsertedAtTop.push(styleElement);
		} else if (options.insertAt === "bottom") {
			head.appendChild(styleElement);
		} else {
			throw new Error("Invalid value for parameter 'insertAt'. Must be 'top' or 'bottom'.");
		}
	}

	function removeStyleElement(styleElement) {
		styleElement.parentNode.removeChild(styleElement);
		var idx = styleElementsInsertedAtTop.indexOf(styleElement);
		if(idx >= 0) {
			styleElementsInsertedAtTop.splice(idx, 1);
		}
	}

	function createStyleElement(options) {
		var styleElement = document.createElement("style");
		styleElement.type = "text/css";
		insertStyleElement(options, styleElement);
		return styleElement;
	}

	function createLinkElement(options) {
		var linkElement = document.createElement("link");
		linkElement.rel = "stylesheet";
		insertStyleElement(options, linkElement);
		return linkElement;
	}

	function addStyle(obj, options) {
		var styleElement, update, remove;

		if (options.singleton) {
			var styleIndex = singletonCounter++;
			styleElement = singletonElement || (singletonElement = createStyleElement(options));
			update = applyToSingletonTag.bind(null, styleElement, styleIndex, false);
			remove = applyToSingletonTag.bind(null, styleElement, styleIndex, true);
		} else if(obj.sourceMap &&
			typeof URL === "function" &&
			typeof URL.createObjectURL === "function" &&
			typeof URL.revokeObjectURL === "function" &&
			typeof Blob === "function" &&
			typeof btoa === "function") {
			styleElement = createLinkElement(options);
			update = updateLink.bind(null, styleElement);
			remove = function() {
				removeStyleElement(styleElement);
				if(styleElement.href)
					URL.revokeObjectURL(styleElement.href);
			};
		} else {
			styleElement = createStyleElement(options);
			update = applyToTag.bind(null, styleElement);
			remove = function() {
				removeStyleElement(styleElement);
			};
		}

		update(obj);

		return function updateStyle(newObj) {
			if(newObj) {
				if(newObj.css === obj.css && newObj.media === obj.media && newObj.sourceMap === obj.sourceMap)
					return;
				update(obj = newObj);
			} else {
				remove();
			}
		};
	}

	var replaceText = (function () {
		var textStore = [];

		return function (index, replacement) {
			textStore[index] = replacement;
			return textStore.filter(Boolean).join('\n');
		};
	})();

	function applyToSingletonTag(styleElement, index, remove, obj) {
		var css = remove ? "" : obj.css;

		if (styleElement.styleSheet) {
			styleElement.styleSheet.cssText = replaceText(index, css);
		} else {
			var cssNode = document.createTextNode(css);
			var childNodes = styleElement.childNodes;
			if (childNodes[index]) styleElement.removeChild(childNodes[index]);
			if (childNodes.length) {
				styleElement.insertBefore(cssNode, childNodes[index]);
			} else {
				styleElement.appendChild(cssNode);
			}
		}
	}

	function applyToTag(styleElement, obj) {
		var css = obj.css;
		var media = obj.media;

		if(media) {
			styleElement.setAttribute("media", media)
		}

		if(styleElement.styleSheet) {
			styleElement.styleSheet.cssText = css;
		} else {
			while(styleElement.firstChild) {
				styleElement.removeChild(styleElement.firstChild);
			}
			styleElement.appendChild(document.createTextNode(css));
		}
	}

	function updateLink(linkElement, obj) {
		var css = obj.css;
		var sourceMap = obj.sourceMap;

		if(sourceMap) {
			// http://stackoverflow.com/a/26603875
			css += "\n/*# sourceMappingURL=data:application/json;base64," + btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap)))) + " */";
		}

		var blob = new Blob([css], { type: "text/css" });

		var oldSrc = linkElement.href;

		linkElement.href = URL.createObjectURL(blob);

		if(oldSrc)
			URL.revokeObjectURL(oldSrc);
	}


/***/ }
/******/ ]);