include .env

GITEA_BASE_URL=$(subst ',,$(GITEA_URL))

.PHONY:

package-exists:
	@[ -d "$(PACKAGE)" ] || (echo "Package '$(PACKAGE)' does not exist" && exit 1)

publish: package-exists
	@echo "Compressing..."
	@zip -r "$(PACKAGE).zip" "$(PACKAGE)"
	@echo "Uploading..."
	curl --user $(GITEA_USER):$(GITEA_PAT) \
		--upload-file "$(PACKAGE).zip" \
		$(GITEA_BASE_URL)/api/packages/lstellway/composer

