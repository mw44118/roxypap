// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var reload_globalnav = function () {
    $("#globalnav").load(document.URL + " #globalnav li");
};
