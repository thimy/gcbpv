var t="undefined"!==typeof globalThis?globalThis:"undefined"!==typeof self?self:global;var i={};!function(t,a){i=a()}(window,(function(){return function(t){var i={};function n(a){if(i[a])return i[a].exports;var l=i[a]={i:a,l:!1,exports:{}};return t[a].call(l.exports,l,l.exports,n),l.l=!0,l.exports}return n.m=t,n.c=i,n.d=function(t,i,a){n.o(t,i)||Object.defineProperty(t,i,{enumerable:!0,get:a})},n.r=function(t){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},n.t=function(t,i){if(1&i&&(t=n(t)),8&i)return t;if(4&i&&"object"==typeof t&&t&&t.__esModule)return t;var a=Object.create(null);if(n.r(a),Object.defineProperty(a,"default",{enumerable:!0,value:t}),2&i&&"string"!=typeof t)for(var l in t)n.d(a,l,function(i){return t[i]}.bind(null,l));return a},n.n=function(t){var i=t&&t.__esModule?function(){return t.default}:function(){return t};return n.d(i,"a",i),i},n.o=function(t,i){return Object.prototype.hasOwnProperty.call(t,i)},n.p="/",n(n.s=4)}([function(t,i,a){var l=a(1),f=a(2);"string"==typeof(f=f.__esModule?f.default:f)&&(f=[[t.i,f,""]]);var v={insert:"head",singleton:!1};l(f,v);t.exports=f.locals||{}},function(t,i,a){var l,o=function(){return void 0===l&&(l=Boolean(window&&document&&document.all&&!window.atob)),l},f=function(){var t={};return function(i){if(void 0===t[i]){var a=document.querySelector(i);if(window.HTMLIFrameElement&&a instanceof window.HTMLIFrameElement)try{a=a.contentDocument.head}catch(t){a=null}t[i]=a}return t[i]}}(),v=[];function u(t){for(var i=-1,a=0;a<v.length;a++)if(v[a].identifier===t){i=a;break}return i}function c(t,i){for(var a={},l=[],f=0;f<t.length;f++){var h=t[f],y=i.base?h[0]+i.base:h[0],m=a[y]||0,g="".concat(y," ").concat(m);a[y]=m+1;var S=u(g),w={css:h[1],media:h[2],sourceMap:h[3]};-1!==S?(v[S].references++,v[S].updater(w)):v.push({identifier:g,updater:b(w,i),references:1}),l.push(g)}return l}function s(t){var i=document.createElement("style"),l=t.attributes||{};if(void 0===l.nonce){var v=a.nc;v&&(l.nonce=v)}if(Object.keys(l).forEach((function(t){i.setAttribute(t,l[t])})),"function"==typeof t.insert)t.insert(i);else{var h=f(t.insert||"head");if(!h)throw new Error("Couldn't find a style target. This probably means that the value for the 'insert' parameter is invalid.");h.appendChild(i)}return i}var h,y=(h=[],function(t,i){return h[t]=i,h.filter(Boolean).join("\n")});function d(t,i,a,l){var f=a?"":l.media?"@media ".concat(l.media," {").concat(l.css,"}"):l.css;if(t.styleSheet)t.styleSheet.cssText=y(i,f);else{var v=document.createTextNode(f),h=t.childNodes;h[i]&&t.removeChild(h[i]),h.length?t.insertBefore(v,h[i]):t.appendChild(v)}}function p(t,i,a){var l=a.css,f=a.media,v=a.sourceMap;if(f?t.setAttribute("media",f):t.removeAttribute("media"),v&&"undefined"!=typeof btoa&&(l+="\n/*# sourceMappingURL=data:application/json;base64,".concat(btoa(unescape(encodeURIComponent(JSON.stringify(v))))," */")),t.styleSheet)t.styleSheet.cssText=l;else{for(;t.firstChild;)t.removeChild(t.firstChild);t.appendChild(document.createTextNode(l))}}var m=null,g=0;function b(t,i){var a,l,f;if(i.singleton){var v=g++;a=m||(m=s(i)),l=d.bind(null,a,v,!1),f=d.bind(null,a,v,!0)}else a=s(i),l=p.bind(null,a,i),f=function(){!function(t){if(null===t.parentNode)return!1;t.parentNode.removeChild(t)}(a)};return l(t),function(i){if(i){if(i.css===t.css&&i.media===t.media&&i.sourceMap===t.sourceMap)return;l(t=i)}else f()}}t.exports=function(t,i){(i=i||{}).singleton||"boolean"==typeof i.singleton||(i.singleton=o());var a=c(t=t||[],i);return function(t){if(t=t||[],"[object Array]"===Object.prototype.toString.call(t)){for(var l=0;l<a.length;l++){var f=u(a[l]);v[f].references--}for(var h=c(t,i),y=0;y<a.length;y++){var m=u(a[y]);0===v[m].references&&(v[m].updater(),v.splice(m,1))}a=h}}}},function(t,i,a){(i=a(3)(!1)).push([t.i,".cdx-underline {\n    text-decoration: underline;\n}\n",""]),t.exports=i},function(i,a,l){i.exports=function(i){var a=[];return a.toString=function(){return this.map((function(t){var a=function(t,i){var a=t[1]||"",l=t[3];if(!l)return a;if(i&&"function"==typeof btoa){var f=(h=l,y=btoa(unescape(encodeURIComponent(JSON.stringify(h)))),m="sourceMappingURL=data:application/json;charset=utf-8;base64,".concat(y),"/*# ".concat(m," */")),v=l.sources.map((function(t){return"/*# sourceURL=".concat(l.sourceRoot||"").concat(t," */")}));return[a].concat(v).concat([f]).join("\n")}var h,y,m;return[a].join("\n")}(t,i);return t[2]?"@media ".concat(t[2]," {").concat(a,"}"):a})).join("")},a.i=function(i,l,f){"string"==typeof i&&(i=[[null,i,""]]);var v={};if(f)for(var h=0;h<(this||t).length;h++){var y=(this||t)[h][0];null!=y&&(v[y]=!0)}for(var m=0;m<i.length;m++){var g=[].concat(i[m]);f&&v[g[0]]||(l&&(g[2]?g[2]="".concat(l," and ").concat(g[2]):g[2]=l),a.push(g))}},a}},function(i,a,l){l.r(a),l.d(a,"default",(function(){return f}));l(0);function r(t){return(r="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(t){return typeof t}:function(t){return t&&"function"==typeof Symbol&&t.constructor===Symbol&&t!==Symbol.prototype?"symbol":typeof t})(t)}function o(t,i){for(var a=0;a<i.length;a++){var l=i[a];l.enumerable=l.enumerable||!1,l.configurable=!0,"value"in l&&(l.writable=!0),Object.defineProperty(t,(f=l.key,v=void 0,v=function(t,i){if("object"!==r(t)||null===t)return t;var a=t[Symbol.toPrimitive];if(void 0!==a){var l=a.call(t,i||"default");if("object"!==r(l))return l;throw new TypeError("@@toPrimitive must return a primitive value.")}return("string"===i?String:Number)(t)}(f,"string"),"symbol"===r(v)?v:String(v)),l)}var f,v}var f=function(){function e(i){var a=i.api;!function(t,i){if(!(t instanceof i))throw new TypeError("Cannot call a class as a function")}(this||t,e),(this||t).api=a,(this||t).button=null,(this||t).tag="U",(this||t).iconClasses={base:(this||t).api.styles.inlineToolButton,active:(this||t).api.styles.inlineToolButtonActive}}var i,a,l;return i=e,l=[{key:"CSS",get:function(){return"cdx-underline"}},{key:"isInline",get:function(){return!0}},{key:"sanitize",get:function(){return{u:{class:e.CSS}}}}],(a=[{key:"render",value:function(){return(this||t).button=document.createElement("button"),(this||t).button.type="button",(this||t).button.classList.add((this||t).iconClasses.base),(this||t).button.innerHTML=(this||t).toolboxIcon,(this||t).button}},{key:"surround",value:function(i){if(i){var a=(this||t).api.selection.findParentTag((this||t).tag,e.CSS);a?this.unwrap(a):this.wrap(i)}}},{key:"wrap",value:function(i){var a=document.createElement((this||t).tag);a.classList.add(e.CSS),a.appendChild(i.extractContents()),i.insertNode(a),(this||t).api.selection.expandToTag(a)}},{key:"unwrap",value:function(i){(this||t).api.selection.expandToTag(i);var a=window.getSelection(),l=a.getRangeAt(0),f=l.extractContents();i.parentNode.removeChild(i),l.insertNode(f),a.removeAllRanges(),a.addRange(l)}},{key:"checkState",value:function(){var i=(this||t).api.selection.findParentTag((this||t).tag,e.CSS);(this||t).button.classList.toggle((this||t).iconClasses.active,!!i)}},{key:"toolboxIcon",get:function(){return'<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24"><path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 7.5V11.5C9 12.2956 9.31607 13.0587 9.87868 13.6213C10.4413 14.1839 11.2044 14.5 12 14.5C12.7956 14.5 13.5587 14.1839 14.1213 13.6213C14.6839 13.0587 15 12.2956 15 11.5V7.5"/><path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7.71429 18H16.2857"/></svg>'}}])&&o(i.prototype,a),l&&o(i,l),Object.defineProperty(i,"prototype",{writable:!1}),e}()}]).default}));var a=i;const l=i.Underline;export{l as Underline,a as default};
