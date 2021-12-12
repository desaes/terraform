variable "myvar" {
  type    = string
  default = "hello"
}

// var.myvar
// "${var.myvar}"

variable "mymap" {
  type = map(string)
  default = {
    mykey = "my value"
  }
}

// var.mymap.mykey
// var.mymap["mykey"]
// "${var.mymap.mykey}"
// "${var.mymap["mykey"]}"

variable "mylist" {
  type    = list(any)
  default = [1, 2, 3]
}

// var.mylist
// var.mylist[0]
// element(var.mylist, 1)
// slice(var.mylist, 0, 2)