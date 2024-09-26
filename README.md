API that provides both text and images for testing purposes. A good one to use is the **[JSONPlaceholder Photo API](https://jsonplaceholder.typicode.com/photos)**, which returns a list of photo objects containing both image URLs and associated text.

Here's an example of the structure you get from the `https://jsonplaceholder.typicode.com/photos` API:

```json
[
  {
    "albumId": 1,
    "id": 1,
    "title": "accusamus beatae ad facilis cum similique qui sunt",
    "url": "https://via.placeholder.com/600/92c952",
    "thumbnailUrl": "https://via.placeholder.com/150/92c952"
  },
  {
    "albumId": 1,
    "id": 2,
    "title": "reprehenderit est deserunt velit ipsam",
    "url": "https://via.placeholder.com/600/771796",
    "thumbnailUrl": "https://via.placeholder.com/150/771796"
  },
  ...
]
```

Each object contains:
- `title`: A text description of the image.
- `url`: A URL pointing to the full-sized image.
- `thumbnailUrl`: A URL pointing to a smaller thumbnail version of the image.

### How to Use It
You can replace your API call URL with `https://jsonplaceholder.typicode.com/photos` and modify the model accordingly to include `title`, `url`, and `thumbnailUrl`.

#### Updated Model

```swift
import Foundation

// Model
struct Photo: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String         // Full-sized image URL
    let thumbnailUrl: String // Thumbnail image URL
}
```

#### Updated API Service

```swift
import Foundation

class APIService {
    // Fetch Photos from API
    func fetchPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                completion(.success(photos))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}
```

You can now fetch both text (the `title`) and image (from `url` or `thumbnailUrl`) to display in your table view.

### Updating the ViewController and Cell

Instead of the previous `Post`, you can use `Photo`, where each table view cell will show the `title` and the corresponding image.

This approach will allow you to use public data, making it easier to test your app with real text and image data from an API.
