import { Controller } from "@hotwired/stimulus"
import EditorJS from "@editorjs/editorjs"
import AttachesTool from "@editorjs/attaches"
import Delimiter from "@editorjs/delimiter"
import Embed from "@editorjs/embed"
import Header from "@editorjs/header"
import ImageTool from "@editorjs/image"
import Marker from "@editorjs/marker"
import List from "@editorjs/list"
import Paragraph from "@editorjs/paragraph"
import Table from "@editorjs/table"
import TextVariantTune from "@editorjs/text-variant-tune"
import Underline from "@editorjs/underline"


export default class extends Controller {
  static targets = ["editor", "hidden"]
  static values = { imageUrl: String, fileUrl: String }

  connect() {
    const initialContent = this.getInitialContent()
    this.editor = new EditorJS({
      holder: this.editorTarget,
      data: initialContent,
      placeholder: "Commencez à écrire ici...",
      tools: {
        attaches: {
          class: AttachesTool,
          config: {
            endpoint: this.fileUrlValue,
            buttonText: "Ajouter un fichier",
            errorMessage: "L’envoi de l’image a échoué",
            additionalRequestHeaders: {
              "X-CSRF-Token": this.csrfToken()
            }
          }
        },
        embed: {
          class: Embed
        },
        header: {
          class: Header
        },
        image: {
          class: ImageTool,
          config: {
            endpoints: {
              byFile: this.fileUrlValue
            },
            additionalRequestHeaders: {
              "X-CSRF-Token": this.csrfToken()
            }
          }
        },
        list: {
          class: List,
          inlineToolbar: true,
        },
        marker: {
          class: Marker,
          shortcut: 'CMD+SHIFT+M'
        },
        paragraph: {
          class: Paragraph,
          config: {
            inlineToolbar: true
          }
        },
        table: {
          class: Table,
          inlineToolbar: true,
          config: {
            rows: 2,
            cols: 3,
          },
        },
        textVariant: TextVariantTune,
        underline: {
          class: Underline
        },
      },
      tunes: ["textVariant"],
      i18n: {
        messages: {
          ui: {
            blockTunes: {
              toggler: {
                "Click to tune": "Cliquez pour modifier",
                "or drag to move": "ou glissez pour déplacer"
              }
            },
            inlineToolbar: {
              converter: {
                "Convert to": "Convertir en"
              }
            },
            popover: {
              Filter: "Filtrer",
              "Convert to": "Convertir en",
              "Nothing found": "Aucun résultat"
            },
            toolbar: {
              toolbox: {
                "Add": "Ajouter",
                "Text": "Texte"
              }
            }
          },
          toolNames: {
            "Filter": "Filtrer",
            "Text": "Texte",
            "Heading": "Titre",
            "List": "Liste",
            "Warning": "Alerte",
            "Checklist": "Liste à cocher",
            "Quote": "Citation",
            "Delimiter": "Délimiteur",
            "Table": "Tableau",
            "Link": "Lien",
            "Marker": "Marqueur",
            "Bold": "Gras",
            "Italic": "Italique",
            "Underline": "Soulignement",
            "Attachment": "Fichier"
          },
          tools: {
            "header": {
              "Heading 1": "Titre 1",
              "Heading 2": "Titre 2",
              "Heading 3": "Titre 3",
              "Heading 4": "Titre 4",
              "Heading 5": "Titre 5",
              "Heading 6": "Titre 6"
            },
            "image": {
              "Select an Image": "Sélectionnez une image",
              "Caption": "Légende",
              "With border": "Avec bordure",
              "Stretch image": "Étirer l’image",
              "With background": "Avec fond",
            },
            "link": {
              "Add a link": "Ajouter un lien"
            },
            "list": {
              "Ordered": "Numérotée",
              "Unordered": "Non-numérotée",
              "Convert to": "Convertir en"
            },
            "paragraph": {
              "Call-out": "Alerte",
              "Details": "Accordéon"
            },
            "table": {
              "Add column to left": "Ajouter une colonne à gauche",
              "Add column to right": "Ajouter une colonne à droite",
              "Add row above": "Ajouter une ligne au-dessus",
              "Add row below": "Ajouter une colonne en dessous",
              "Delete column": "Supprimer la colonne",
              "Delete row": "Supprimer la ligne",
              "With headings": "Avec titres de colonnes",
              "Without headings": "Sans titres"
            },
            "stub": {
              "The block can not be displayed correctly.": "Le bloc ne peut pas être affiché correctement"
            }
          },
          blockTunes: {
            "convertTo": {
              "Convert to" :"Convertir en"
              },
            "delete": {
              "Delete": "Supprimer",
              "Click to delete": "Cliquer pour supprimer"
            },
            "moveUp": {
              "Move up": "Déplacer vers le haut"
            },
            "moveDown": {
              "Move down": "Déplacer vers le bas"
            }
          }
        }
      }
    })

    this.element.addEventListener("submit", this.saveEditorData.bind(this))
  }

  getInitialContent() {
    const hiddenContentField = this.hiddenTarget
    if (hiddenContentField && hiddenContentField.value) {
      return JSON.parse(hiddenContentField.value)
    }
  }

  async saveEditorData(event) {
    event.preventDefault()

    const outputData = await this.editor.save()
    const form = this.element

    const hiddenInput = this.hiddenTarget

    hiddenInput.value = JSON.stringify(outputData)
    form.submit()
  }

  csrfToken() {
    const metaTag = document.querySelector("meta[name='csrf-token']")
    return metaTag ? metaTag.content : ""
  }
}
