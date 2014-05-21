module.exports = {
  "read": {
    "id":26,
    "email_address":"liz@example.com",
    "name":"Liz",
    "tracking_pixel": require("./tracking_pixel.js").read
  },
  "unread": {
    "id":27,
    "email_address":"julian@example.com",
    "name":"Julian",
    "tracking_pixel": require("./tracking_pixel.js").unread
  },
  "unopened": {
    "id":28,
    "email_address":"jacob@example.com",
    "name":"Jacob",
    "tracking_pixel": require("./tracking_pixel.js").unsent
  }
}
