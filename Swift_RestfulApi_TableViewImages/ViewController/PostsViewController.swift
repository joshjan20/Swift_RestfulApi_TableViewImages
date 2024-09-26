//
//  PostsViewController.swift
//  Swift_RestfulApi_TableViewImages
//
//  Created by JJ on 26/09/24.
//

import UIKit

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var viewModel = PostsViewModel()
    private var postsView: PostsView!
    
    override func loadView() {
        postsView = PostsView()
        self.view = postsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        
        setupTableView()
        setupBindings()
        
        viewModel.fetchPosts() // Fetch posts from ViewModel
    }
    
    private func setupTableView() {
        postsView.tableView.delegate = self
        postsView.tableView.dataSource = self
        postsView.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
    }
    
    private func setupBindings() {
        viewModel.reloadTableView = { [weak self] in
            self?.postsView.tableView.reloadData()
        }
    }

    // MARK: - UITableView DataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        let post = viewModel.posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }

    // Optional: Adjust row height based on image size
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust based on your design
    }
}

