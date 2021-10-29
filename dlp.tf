resource "google_data_loss_prevention_job_trigger" "fail" {
    parent = "projects/my-project-name"
    description = "Description"
    display_name = "Displayname"

    triggers {
        schedule {
            recurrence_period_duration = "86400s"
        }
    }
    
}

resource "google_data_loss_prevention_job_trigger" "pass" {
    parent = "projects/my-project-name"
    description = "Description"
    display_name = "Displayname"

    triggers {
        schedule {
            recurrence_period_duration = "86400s"
        }
    }

    inspect_job {
        inspect_template_name = "fake"
        actions {
            save_findings {
                output_config {
                    table {
                        project_id = "asdf"
                        dataset_id = "asdf"
                    }
                }
            }
        }
        storage_config {
            cloud_storage_options {
                file_set {
                    url = "gs://mybucket/directory/"
                }
            }
        }
    }
}