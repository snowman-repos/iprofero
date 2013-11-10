mongoose = require("mongoose")
Schema = mongoose.Schema

# uploads_base = "/uploads"

# # Picture Model

PictureSchema = new Schema(
	user_id: String
)

# PictureSchema.plugin(mongooseThumbnailPlugin,
# 	name: "avatar.file"
# 	upload_to: uploads_base
# )

mongoose.model "Picture", PictureSchema