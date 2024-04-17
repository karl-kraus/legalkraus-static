/*
##################################################################
get container holding images urls as child elements
get container for osd viewer
get container wrapper of osd viewer
##################################################################
*/
// var container = document.getElementById("container_facs_2");
// container.style.display = "none";
var height = screen.height;
var container = document.getElementById("container_facs_1");
var wrapper = document.getElementsByClassName("facsimiles")[0];

/*
##################################################################
check if osd viewer is visible or not
if true get width from sibling container
if false get with from sibling container divided by half
height is always the screen height minus some offset
##################################################################
*/
if (!wrapper.classList.contains("fade")) {
    container.style.height = `${String(height / 1)}px`;
    // set osd wrapper container width
    var container = document.getElementById("section");
    if (container !== null) {
        var width = container.clientWidth;
    }
    var container = document.getElementById("viewer");
    container.style.width = `${String(width - 25)}px`;
} else {
    container.style.height = `${String(height / 1)}px`;
    // set osd wrapper container width
    var container = document.getElementById("section");
    if (container !== null) {
        var width = container.clientWidth;
    }
    var container = document.getElementById("viewer");
    container.style.width = `${String(width / 0.7)}px`;
}

/*
##################################################################
get all image urls stored in span el class tei-xml-images
creates an array for osd viewer with static images
##################################################################
*/
var tileSources = [];
if (document.getElementById("page-selector")) {
  [...document.getElementById("page-selector").options].map(o => {
    var imageURL = {
      type: 'image',
      url:  o.value
    };
    tileSources.push(imageURL)
  })
}

/*
##################################################################
initialize osd
##################################################################
*/
var viewer = OpenSeadragon({
    id: 'container_facs_1',
    prefixUrl: 'https://cdnjs.cloudflare.com/ajax/libs/openseadragon/4.0.0/images/',
    sequenceMode: true,
    showNavigator: false,
    tileSources: tileSources
});
/*
##################################################################
remove container holding the images url
##################################################################
*/
// setTimeout(function() {
//     document.getElementById("container_facs_2").remove();
// }, 500);

/*
##################################################################
index and previous index for click navigation in osd viewer
locate index of anchor element
##################################################################
*/
var idx = 0;
var prev_idx = -1;



/*
##################################################################
disable prev next paging selectors
##################################################################
*/


/*
##################################################################
function to trigger image load and remove events
##################################################################
*/
function loadNewImage(new_image) {
    if (new_image) {
        // source attribute hold image item id without url
        //var new_image = new_item.getAttribute("source");
        var old_image = viewer.world.getItemAt(0);
        if (old_image) {
            // get url from current/old image and replace the image id with
            // new id of image to be loaded
            // access osd viewer and add simple image and remove current image
            viewer.addSimpleImage({
                url: new_image,
                success: function(event) {
                    function ready() {
                        setTimeout(() => {
                            viewer.world.removeItem(viewer.world.getItemAt(0));
                        }, 200)
                    }
                    // test if item was loaded and trigger function to remove previous item
                    if (event.item) {
                        // .getFullyLoaded()
                        ready();
                    } else {
                        event.item.addOnceHandler('fully-loaded-change', ready());
                    }
                }
            });
        }
    }
}

/*
##################################################################
accesses osd viewer prev and next button to switch image and
scrolls to next or prev span element with class pb (pagebreak)
##################################################################
*/
var element_a = document.getElementsByClassName('anchor-pb');
var prev = document.querySelector("div[title='Previous page']");
var next = document.querySelector("div[title='Next page']");
prev.style.opacity = 1;
next.style.opacity = 1;
prev.addEventListener("click", () => {
    if (idx == 0) {
        element_a[idx].scrollIntoView();
    } else {
        element_a[prev_idx].scrollIntoView();
    }
});
next.addEventListener("click", () => {
    element_a[idx].scrollIntoView();
});

/*
##################################################################
function to check if element is close to top of window viewport
##################################################################
*/
function isInViewport(element) {
    // Get the bounding client rectangle position in the viewport
    var bounding = element.getBoundingClientRect();
    // Checking part. Here the code checks if el is close to top of viewport.
    // console.log("Top");
    // console.log(bounding.top);
    // console.log("Bottom");
    // console.log(bounding.bottom);
    if (
        bounding.top <= 180 &&
        bounding.bottom <= 210 &&
        bounding.top >= 0 &&
        bounding.bottom >= 0
    ) {
        return true;
    } else {
        return false;
    }
}

/*
##################################################################
function to check if element is anywhere in window viewport
##################################################################
*/
function isInViewportAll(element) {
    // Get the bounding client rectangle position in the viewport
    var bounding = element.getBoundingClientRect();
    // Checking part. Here the code checks if el is close to top of viewport.
    // console.log("Top");
    // console.log(bounding.top);
    // console.log("Bottom");
    // console.log(bounding.bottom);
    if (
        bounding.top >= 0 &&
        bounding.left >= 0 &&
        bounding.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
        bounding.right <= (window.innerWidth || document.documentElement.clientWidth)
    ) {
        return true;
    } else {
        return false;
    }
}


/*
##################################################################
page selector
##################################################################
*/

togglePrevNextPaging()


function selectPage(direction) { 
  pageSelector = document.getElementById("page-selector");
  
  if (direction == 'prev') {
    pageSelector.selectedIndex = pageSelector.selectedIndex - 1;
  }

  if (direction == 'next') {
    pageSelector.selectedIndex = pageSelector.selectedIndex + 1;
  }

  imageURL = pageSelector.value;
  pageNr = pageSelector[pageSelector.selectedIndex].text;
 
  togglePrevNextPaging()
  
  loadNewImage(imageURL);

  [...document.querySelectorAll('[id^="page_"]')].forEach(el => {
    el.classList.remove("d-block");
    el.classList.add("d-none")
    }
  )
  document.getElementById(`page_${pageNr}`).classList.remove("d-none")
  document.getElementById(`page_${pageNr}`).classList.add("d-block")
}


function togglePrevNextPaging() {
  pageSelector = document.getElementById("page-selector");
  if (pageSelector.selectedIndex == 0) {
    document.getElementById("nextPage").disabled = false;
    document.getElementById("prevPage").disabled = true;
  }
   else if (pageSelector.selectedIndex == pageSelector.length - 1) {
    document.getElementById("prevPage").disabled = false;
    document.getElementById("nextPage").disabled = true;
  }
  else {
    document.getElementById("prevPage").disabled = false;
    document.getElementById("nextPage").disabled = false;
  }
}
