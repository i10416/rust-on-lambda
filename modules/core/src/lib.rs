pub async fn do_some_complex_task() {
    let _ = reqwest::Client::new();
    // do something with reqwest client
    // (e.g. get configuration value from AWS AppConfig via Lambda Layer)
}
