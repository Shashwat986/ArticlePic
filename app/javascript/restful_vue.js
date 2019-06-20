const axios = require('axios');

/*
RegExp.escape = function(s) {
    return s.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
};
*/

function validRoutes (routes) {
  for (var key in routes) {
  }

  return true;
}

function convertToRegex (route) {
  let newRoute = route.replace(/[-\/\\^$*+?.()|[\]]/g, '\\$&')
  newRoute = newRoute.replace(/\{\w+\}/g, '\\w+')

  return new RegExp(newRoute);
}

function setPathParams (key, route, path) {
  let newRoute = route.replace(/[-\/\\^$*+?.()|[\]]/g, '\\$&')
  let replaceables = newRoute.match(/\{\w+\}/g)

  if (replaceables == null) {
    return path;
  }

  newRoute = newRoute.replace(/\{\w+\}/g, '(\\w+)')
  let regex = new RegExp(newRoute);

  let values = key.match(regex)

  for (let i = 0; i < replaceables.length; i++) {
    path = path.replace(replaceables[i], values[i+1]);
  }

  return path;
}

function getValidRoute (key, routes) {
  let ans = null;
  Object.keys(routes).forEach((val) => {
    let match = key.match(convertToRegex(val));
    if (match && key === match[0]) {
      let newPath = setPathParams(key, val, routes[val].path)

      ans = {
        ...routes[val],
        ...{
          route: val,
          key: key,

          path: newPath,
          method: routes[val].method.toLowerCase()
        }
      };
    }
  });
  return ans;
}

export default {
  install: function (Vue, options) {
    if (options.routes == null) {
      // TODO
      return;
    }

    if (!validRoutes(options.routes)) {
      // TODO
      return;
    }

    Vue.mixin({
      data: function () {
        return {
          restfulData: {}
        };
      },
      mounted: function () {
        let fetchData = this.$options.fetchData;
        if (fetchData != null && Array.isArray(fetchData)) {
          fetchData.forEach((elem) => {
            let validRoute = getValidRoute(elem, options.routes);

            if (validRoute) {
              console.log("Got route", validRoute);
              axios[validRoute.method](options.baseUrl + validRoute.path)
                .then((response) => {
                  console.log(response.data);
                  this.$set(this.restfulData, elem, response.data);
                });
            }
          })
        }
      }
    })
  }
}
