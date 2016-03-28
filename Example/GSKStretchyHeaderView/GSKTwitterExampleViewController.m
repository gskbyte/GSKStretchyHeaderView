#import "GSKTwitterExampleViewController.h"
#import "GSKTwitterStretchyHeaderView.h"

@interface GSKTwitterExampleViewController () <GSKTwitterStretchyHeaderViewDelegate>

@end

@implementation GSKTwitterExampleViewController

- (GSKStretchyHeaderView *)loadStretchyHeaderView {
    GSKTwitterStretchyHeaderView *headerView = [[GSKTwitterStretchyHeaderView alloc] initWithFrame:self.tableView.bounds];
    headerView.delegate = self;
    return headerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES
                                             animated:NO];
}

- (void)headerView:(GSKTwitterStretchyHeaderView *)headerView didTapBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
