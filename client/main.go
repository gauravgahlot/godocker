package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"time"
)

func main() {
	http.HandleFunc("/", homeHandler)
	http.HandleFunc("/posts", postsHandler)

	http.ListenAndServe(":8000", nil)
}

func homeHandler(w http.ResponseWriter, r *http.Request) {
	ch := make(chan string)
	go makeRequest("http://go-server:8001/", ch)
	fmt.Fprintf(w, <-ch)
}

func postsHandler(w http.ResponseWriter, r *http.Request) {
	ch := make(chan string)
	go makeRequest("http://go-server:8001/posts", ch)
	fmt.Fprintf(w, <-ch)
}

func makeRequest(url string, ch chan<- string) {
	start := time.Now()
	response, err := http.Get(url)
	secs := time.Since(start).Seconds()

	if err != nil {
		ch <- fmt.Sprintf("Error: %s\n\nElapsed Time: %.2f sec", err, secs)
	} else {
		defer response.Body.Close()
		content, err := ioutil.ReadAll(response.Body)
		if err != nil {
			ch <- fmt.Sprintf("Error: %s\n\nElapsed Time: %.2f sec", err, secs)
		}
		ch <- fmt.Sprintf("%s\n\nElapsed Time: %.2f sec", string(content), secs)
	}
}
