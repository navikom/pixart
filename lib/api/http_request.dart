void request(String method, String url, allHeaders, body, [bool debug = true]) {
  // var headers = Object.assign({}, allHeaders, {
  //   "Accept": "application/json",
  //   "Content-Type": "application/json",
  //   "Cookie": "APP=Admin_Panel"
  // });
  // var object = { method, headers };
  // body && (object.body = JSON.stringify(body));
  // if (debug) {
  //   console.log("REQUEST", url, method, body, headers);
  // }
  // const response = await fetch(url, object);
  // if (debug) {
  //   console.log("RESPONSE", url, response);
  // }
  // const json = await response.json();

  // if (debug) {
  //   console.log("RESPONSE BODY", url, json);
  // }
  // if (!response.ok) {
  //   throw new ErrorHandler(json.error ? json.error : "HTTP Error");
  // }
  // return json.data;
}
