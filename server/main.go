package main

import (
	"encoding/json"
	"net/http"
)

// Post is the base structure for a post
type Post struct {
	Title         string
	Author        string
	DatePublished string
	Content       string
}

func main() {
	http.HandleFunc("/", homeHandler)
	http.HandleFunc("/posts", postsHandler)

	http.ListenAndServe(":8001", nil)
}

func homeHandler(w http.ResponseWriter, r *http.Request) {
	message, _ := json.Marshal("Hello from Go-Server!")

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(message)
}

func postsHandler(w http.ResponseWriter, r *http.Request) {
	jsonData, _ := json.Marshal(getPosts())

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(jsonData)
}

func getPosts() []Post {
	return []Post{
		{
			Title:         "What is Lorem Ipsum?",
			Author:        "Gaurav Gahlot",
			DatePublished: "Aug 20, 2018",
			Content:       "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
		},
		{
			Title:         "Why do we use it?",
			Author:        "Gaurav Gahlot",
			DatePublished: "Aug 27, 2018",
			Content:       "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
		},
		{
			Title:         "Where does it come from?",
			Author:        "Gaurav Gahlot",
			DatePublished: "Sep 03, 2018",
			Content:       "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.",
		},
	}
}
