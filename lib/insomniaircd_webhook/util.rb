
def generate_config(repo, url)
  if File.directory? "repos/#{repo}"
    clone_success = system "cd repos/#{repo} && git pull"
  else
    clone_success = system "git clone #{url} repos/#{repo}"
  end

  if clone_success
    system "cd repos/#{repo} && rake"
  end
end

