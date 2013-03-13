// script to make phantomjs to connect as slave of buster server and report any error from
// browser console to the terminal.
// taken from:
// http://blog.knuthaugen.no/2012/09/headless-tests-with-buster-and-phantom/

var system = require('system'),
    captureUrl = 'http://localhost:1111/capture';

if (system.args.length==2) {
    captureUrl = system.args[1];
}

phantom.silent = false;

var page = new WebPage();

page.open(captureUrl, function(status) {
  if(!phantom.silent) {

    if (status !== 'success') {
      console.log('phantomjs failed to connect');
      phantom.exit(1);
    }

    page.onConsoleMessage = function (msg, line, id) {
      var fileName = id.split('/');
      console.log(fileName[fileName.length-1]+', '+ line +': '+ msg);
    };

    page.onAlert = function(msg) {
      console.log(msg);
    };
  }
});